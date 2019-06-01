class Address < ApplicationRecord
  has_many :meetings
  validate :address_unique

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
