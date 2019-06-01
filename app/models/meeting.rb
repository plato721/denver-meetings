class Meeting < ActiveRecord::Base
  belongs_to :address

  validate :raw_meeting_unique, on: :create
  belongs_to :raw_meeting

  def self.geocoded
    where.not(lat: nil).where.not(lng: nil)
  end

  def self.visible
    where(visible: true)
  end

  def self.open
    where(closed: [false, nil])
  end

  def self.closed
    where(closed: true)
  end

  def raw_meeting_unique
    # one can create a meeting without a raw meeting. but if it is passed, it
    #   must be unique.
    if Meeting.find_by(raw_meeting_id: raw_meeting_id)
      errors.add(:raw_meeting_id, "must be unique")
    end
  end

  def self.by_group_name(group_name)
    group_name = "any" if group_name == ""
    group_name == "any" ? all : where("group_name LIKE ?", "%#{group_name}%")
  end

  def self.by_city(city)
    city == "any" ? all : where("city LIKE ?", "%#{city}%")
  end

  def self.by_open(open)
    return all if open == "any"

    open == "closed" ? closed : self.open
  end

  def self.by_day(day)
    day == "any" ? all : where("day LIKE ?", "%#{day}%")
  end

  def self.by_time(time)
    if SearchOptions.display_range_to_raw.keys.include?(time)
      by_time_range(time)
    else
      time == "any" ? all : where(time: time)
    end
  end

  def self.by_time_range(range)
    range = SearchOptions.display_range_to_raw[range]
    where("time BETWEEN ? AND ?", range.first, range.second).order(:time)
  end

  def self.by_address_1(text)
    where("address_1 LIKE ?", text)
  end

  def self.attribute_map(attribute)
    {"show" => [true, false, nil],
    "only" => true,
    "hide" => false}
  end

  def self.by_attributes(attributes, scope=self)
    attributes.reduce(scope) do |scope, (prop, value)|
      search_command = attribute_map(prop)[value]
      scope.where(prop => search_command)
    end
  end

  def self.search(params)
    scope = self.visible
      .by_group_name(params[:group_name])
      .by_group_name(params[:free])
      .by_city(params[:city])
      .by_day(params[:day])
      .by_time(params[:time])
      .by_open(params[:open])

    attributes = {
      young_people: (params[:youth]),
      gay: (params[:gay]),
      men: (params[:men]),
      women: (params[:women]),
      polish: (params[:polish]),
      french: (params[:french]),
      spanish: (params[:spanish]),
      sitter: (params[:sitter]),
      accessible: (params[:access]),
      non_smoking: (params[:non_smoking])
    }

    scope = by_attributes(attributes, scope).distinct
  end

  # Find meetings whose address_1 doesn't jive with the corresponding
  # raw meeting's address field
  def self.bad_address_1_meetings
    meetings = Meeting.includes(:raw_meeting)
                      .where.not(deleted: true)
                      .where(visible: true)
    bad_meetings = meetings.select do |meeting|
      street_address = meeting.address_1
      raw_address = meeting.raw_meeting.address
      match_on = /^#{street_address[0..4]}/ rescue nil
      matches = raw_address.match(match_on) rescue false
      !matches
    end

    bad_meetings.each do |bad_meeting|
      Rails.logger.warn { "Bad meeting found!\n id: #{bad_meeting.id} group_name: #{bad_meeting.group_name} address_1: #{bad_meeting.address_1} raw_address: #{bad_meeting.raw_meeting.address}" }
    end
  end
end
