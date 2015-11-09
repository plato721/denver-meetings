require 'rails_helper'

RSpec.describe RawMeetingMetadata do
  let(:updated) { DateTime.now }

  it "will not store a duplicate update time" do
    count = RawMeetingMetadata.count
    
    RawMeetingMetadata.create(last_update: updated)
    RawMeetingMetadata.create(last_update: updated)

    expect(RawMeetingMetadata.count).to eq(count + 1)
  end
end