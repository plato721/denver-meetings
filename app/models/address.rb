class Address < ApplicationRecord
  has_many :meetings
  validate :address_unique

  attr_reader :geocoder
  attr_accessor :_skip_geocoder

  geocoded_by :address, :latitude => :lat, :longitude => :lng
  # after_validation :geocode, :unless => :_skip_geocoder
  # before_create :custom_reverse, :address_from_coords, :unless => :_skip_geocoder

  def address
    [address_1, city, state].compact.join(', ')
  end

  def custom_reverse
    return if (!self.lat.present? || !self.lng.present?)

    @geocoder ||= Geocoder.search([self.lat, self.lng]).first
  end

  def address_from_coords
    self.zip = self.geocoder.postal_code if self.geocoder.present?
  end

  def address_unique
    if self.class.find_by(
      address_1: address_1,
      address_2: address_2,
      notes: notes,
      city: city,
      state: state
    )
      errors.add(:uniqueness,
        "- Not creating address because there is already an address: #{address_for_validation_error}"
      )
    end
  end

  def address_for_validation_error
    "#{address_1}, #{address_2}, #{city}, #{state}"
  end
end
