class Meeting < ActiveRecord::Base
  geocoded_by :address, :latitude => :lat, :longitude => :lng
  after_validation :geocode
  before_create :address_from_coords
  belongs_to :raw_meeting
  has_many :features
  has_many :foci
  has_many :formats
  has_many :languages

  def self.search(params)
    # by_free(params[:free])
    by_group_name(params[:group_name])
    .by_city(params[:city])
    .by_day(params[:day])
    .by_time(params[:time])
    .distinct
  end

  def self.by_free(text)
    by_group_name(text)
    .by_city(text)
    .by_day(text)
    .by_address_1(text)
    .distinct
    .order(:group_name)
  end
  def self.by_group_name(group_name)
    group_name == "Any" ? all : where("group_name LIKE ?", "%#{group_name}%")
  end

  def self.by_city(city)
    city == "Any" ? all : where("city LIKE ?", "%#{city}%")
  end

  def self.by_day(day)
    day == "Any" ? all : where("day LIKE ?", "%#{day}%")
  end

  def self.by_city(city)
    city == "Any" ? all : where("city LIKE ?", "%#{city}%")
  end

  def self.by_time(time)
    if SearchOptions.display_range_to_raw.keys.include?(time)
      return by_time_range(time)
    else
      time == "Any" ? all : where(time: time)
    end
  end

  def self.by_time_range(range)
    range = SearchOptions.display_range_to_raw[range]
    where("time BETWEEN ? AND ?", range.first, range.second).order(:time)
  end

  def self.by_address_1(text)
    where("address_1 LIKE ?", text)
  end

  def address
    [address_1, city, state].compact.join(', ')
  end

  def geocoder
    geocoder ||= begin
      if lat && lng
        Geocoder.search([self.lat, self.lng])
        .first.data["address_components"]
      else
        [][]
      end
    end
  end

  def calculated_zip
    zip ||= geocoder.last["long_name"]
  end

  def calculated_street_number
    num ||= geocoder[0]["long_name"]
  end

  def calculated_street_name
    name ||= geocoder[1]["short_name"]
  end

  def address_from_coords
    self.zip = calculated_zip
  end
end
