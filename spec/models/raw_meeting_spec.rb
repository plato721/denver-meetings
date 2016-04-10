require 'rails_helper'

RSpec.describe RawMeeting do
  before(:all) do
    @raw_attributes =
      {
        day: "Sunday",
        time: "06:30 AM",
        group_name: "Keeping It Simple",
        address: "3600 S. Clarkson (NE of Ch)",
        city: "Englewood",
        district: "11",
        codes: "*n"
      }

    @raw_stream = @raw_attributes.values
  end

  context "#self.compute_checksum" do
    it "computes checksum based on all raw values" do
      #Meeting name is not guaranteed to be unique. Meeting name and location
      # are not unique as some meeting are throughout the week. Check uniqueness
      # from all values with a checksum
      checksum = RawMeeting.compute_checksum(@raw_stream)

      expect(checksum.is_a?(String)).to be_truthy
      expect(checksum.empty?).to be_falsey
    end

    it "computes the same checksum for the same meeting" do
      checksum = RawMeeting.compute_checksum(@raw_stream)
      recalc = RawMeeting.compute_checksum(@raw_stream)

      expect(checksum).to eq(recalc)
    end
  end

  context "Using #self.add_from" do
    before(:each) do
      RawMeeting.add_from(@raw_stream)
    end

    it "will not create another raw meeting with identical data" do
      raw_count = RawMeeting.count

      RawMeeting.add_from(@raw_stream)

      expect(RawMeeting.count).to eq(raw_count)
    end

    it "returns the meeting created or found as duplicate" do
      meeting = RawMeeting.add_from(@raw_stream)

      expect(meeting.is_a? RawMeeting).to be_truthy
      @raw_attributes.each do |key, value|
        expect(meeting.send(key)).to eq(value)
      end
    end

  end

end
