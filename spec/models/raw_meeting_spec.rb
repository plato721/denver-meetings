require 'rails_helper'

RSpec.describe RawMeeting do
  let!(:raw_attributes) do
    {day: "Sunday",
    group_name: "Keeping It Simple",
    address: "3600 S. Clarkson (NE of Ch)",
    city: "Englewood",
    district: "11",
    codes: "*n",
    time: "06:30 AM"}
  end

  let(:raw_stream) do
    raw_attributes.values
  end

  context "#self.compute_checksum" do
    it "computes checksum based on all raw values" do
      #Meeting name is not guaranteed to be unique. Meeting name and location
      # are not unique as some meeting are throughout the week. Check uniqueness
      # from all values with a checksum
      checksum = RawMeeting.compute_checksum(raw_stream)

      expect(checksum.is_a?(String)).to be_truthy
      expect(checksum.empty?).to be_falsey
    end

    it "computes the same checksum for the same meeting" do
      checksum = RawMeeting.compute_checksum(raw_stream)
      recalc = RawMeeting.compute_checksum(raw_stream)

      expect(checksum).to eq(recalc)
    end
  end

  context "Using #self.add_from" do
    it "will not create another raw meeting with identical data" do
      RawMeeting.add_from(raw_stream)
      RawMeeting.add_from(raw_stream)

      expect(RawMeeting.count).to eq(1)
    end
  end

end