class Address < ApplicationRecord
  has_many :meetings
  validate :address_unique

  geocoded_by :geocoding_string, :latitude => :lat, :longitude => :lng

  def geocoded?
    lat.present? && lng.present?
  end

  def geocoding_string
    [address_1, city, state].compact.join(', ')
  end

  def geocode_with_reverse
    self.geocode
    get_and_store_zip
  end

  def get_and_store_zip
    return if (!self.lat.present? || !self.lng.present?)

    search_result = Geocoder.search([self.lat, self.lng])&.first
    self.zip = zip_from(search_result)
    save
  end

  def zip_from(result)
    result.data["address"]["postcode"] rescue nil
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
