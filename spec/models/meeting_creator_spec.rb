require 'rails_helper'

RSpec.describe MeetingCreator do
  let(:raw_1) do
    { day: "Sunday",
      group_name: "Keeping It Simple",
      address: "3600 S. Clarkson (NE of Ch)",
      city: "Englewood",
      district: "11",
      codes: "*n",
      time: "06:30 AM",
      checksum: "d95875de2f16ece7cbb51763f3c0038f7ea69ae0"
    }
  end
  before do
    WebMock.stub_request(:get,
      "http://maps.googleapis.com/maps/api/geocode/json?address=3600%20S.%20Clarkson,%20Englewood,%20CO&language=en&sensor=false")
    allow_any_instance_of(Meeting).to receive(:calculated_zip).and_return("12345")
  end

  context "with parenthetical location description and minimal codes" do
    before do
      RawMeeting.create(raw_1)
      @creator = MeetingCreator.new(RawMeeting.first)
    end

    it "extracts city" do
      expect(@creator.city).to eq(raw_1[:city])
    end

    it "extracts first line address" do
      expect(@creator.address_1).to eq("3600 S. Clarkson")
    end

    xit "is non-smoking" do
      meeting = @creator.create

      expect true
    end
  end

end