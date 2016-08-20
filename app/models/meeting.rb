class Meeting < ActiveRecord::Base
  attr_reader :geocoder
  attr_accessor :_skip_geocoder

  validate :raw_meeting_unique, on: :create

  # geocoder dependent callbacks
  geocoded_by :address, :latitude => :lat, :longitude => :lng
  after_validation :geocode, :unless => :_skip_geocoder
  before_create :custom_reverse, :address_from_coords, :unless => :_skip_geocoder
  # end geocoder depened callbacks

  belongs_to :raw_meeting

  def self.geocoded
    where.not(lat: nil).where.not(lng: nil)
  end

  def self.visible
    where(visible: true)
  end

  def self.open
    self.where(closed: [false, nil])
  end

  def raw_meeting_unique
    # this allows a meeting to be created without
    #   a raw meeting. but if it's passed, must be unique.
    if Meeting.find_by(raw_meeting_id: raw_meeting_id)
      errors.add(:raw_meeting_id, "must be unique")
    end
  end

  def address
    [address_1, city, state].compact.join(', ')
  end

  def custom_reverse
    return if (!self.lat.present? || !self.lng.present?)
    @geocoder ||= Geocoder.search([self.lat, self.lng]).first
  end

  def address_from_coords
    return if !self.geocoder.present?
    self.zip = self.geocoder.postal_code
    self.address_1 = self.geocoder.street_address
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
    open == "closed" ? self.closed : self.not_closed
  end

  def self.by_day(day)
    day == "any" ? all : where("day LIKE ?", "%#{day}%")
  end

  def self.by_time(time)
    if SearchOptions.display_range_to_raw.keys.include?(time)
      return by_time_range(time)
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

  def self.flag_like_fields
    [:closed, :men, :women, :gay, :young_people, :speaker, :step, :big_book,
    :grapevine, :traditions, :candlelight, :beginners, :asl, :accessible,
    :non_smoking, :sitter, :spanish, :french, :polish]
  end

  def self.not_matcher
    /^not_/
  end

  def self.not_methods(m)
    root = m.to_s.match(not_matcher).post_match
    if !flag_like_fields.include? root.to_sym
      raise NoMethodError, "#{root.to_sym} appears to be a non-bool field"
    end
    self.where(root.to_sym => false)
  end

  def self.method_missing(m, *args)
    return not_methods(m) if m.to_s =~ not_matcher
    raise NoMethodError if !flag_like_fields.include? m
    return self.where(m => true)
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

end
