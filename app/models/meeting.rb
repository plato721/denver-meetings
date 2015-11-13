class Meeting < ActiveRecord::Base
  geocoded_by :address, :latitude => :lat, :longitude => :lng
  after_validation :geocode
  before_create :address_from_coords
  belongs_to :raw_meeting

  def self.by_group(group_name)
    where("group_name LIKE ?", group_name)
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
