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
  context "with parenthetical location description and minimal codes" do
    before do
      RawMeeting.create(raw_1)
      @creator = MeetingCreator.new(RawMeeting.first)
    end
    #address_1", "address_2", "city", "codes", "created_at", "day", "district", "group_name", "id", "lat", "lng", "notes", "phone", "state", "updated_at", "zip
    it "extracts city" do
      expect(@creator.city).to eq(raw_1[:city])
    end

    xit "determines zip" do
      expect(@creator.zip).to eq(80113)
    end

    it "extracts first line address" do
      expect(@creator.address_1).to eq("3600 S. Clarkson")
    end

  end
end