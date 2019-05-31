class MoveAddress
  class << self
    def call(meeting)
      address_attributes = {
        address_1: meeting.address_1,
        address_2: meeting.address_2,
        city: meeting.city,
        state: meeting.state,
        zip: meeting.zip,
        notes: meeting.notes,
        lat: meeting.lat,
        lng: meeting.lng
      }
      address = Address.create(address_attributes)
      address.meetings << meeting
      address
    end
  end
end