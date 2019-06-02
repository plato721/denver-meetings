class MeetingCreator::AddressExtractor < MeetingCreator::BuildAttributes
  attr_reader :raw_meeting

  def self.extract(raw_meeting, _)
    new(raw_meeting).extract
  end

  def initialize(raw_meeting)
    @raw_meeting = raw_meeting
  end

  def extract
    extracted_attributes = build
    address = Address.find_or_create_by(extracted_attributes)
    address.geocode_with_reverse if attempt_geocoding?(address)
    address
  end

  def attempt_geocoding?(address)
    # TODO - consider adding in more sophsticated logic... like has geocoding been
    # attempting? or just get rid of this method and use #geocoded? only
    !address.geocoded?
  end

  def object_attributes
    [
      :address_1,
      :address_2,
      :notes,
      :district,
      :city,
      :state,
      # lat from geocoding
      # lng from geocoding
      # zip from reverse geocoding
    ]
  end
end