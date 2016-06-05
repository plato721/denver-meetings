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

    it "will not add nil codes" do
      attributes = @raw_stream
      attributes.pop

      meeting = RawMeeting.add_from(attributes)

      expect(meeting.is_a? RawMeeting).to be_truthy
      expect(meeting.codes.is_a? String).to be_truthy
    end

  end

  it "loads from yaml" do
    file = Rails.root + 'spec/support/extract.yml'
    raw_meetings = RawMeeting.from_yaml(file)

    expect(raw_meetings.first.day).to eq("Sunday")
    expect(raw_meetings.first.time).to eq("12:00 PM")
    expect(raw_meetings.first.group_name).to eq("Bill's Brownbaggers")
    expect(raw_meetings.first.address).to eq("8250 W. 80th Ave. Unit 12, 303-420-6560")
    expect(raw_meetings.first.city).to eq("Arvada")
    expect(raw_meetings.first.district).to eq("31")
    expect(raw_meetings.first.codes).to eq("*n")

    expect(raw_meetings.second.group_name).to eq("Buckeye Easy Does It")
  end

  context "scope" do
    fixtures :raw_meetings
    fixtures :meetings

    it "scope - raw meetings for which there is a meeting that points to it" do
      results = RawMeeting.for_all_non_daccaa_deleted

      # 0 - are these raw meetings?
      expect( results.all? { |o| o.is_a? RawMeeting } ).to be_truthy

      # 1 - are all the associated meetings extant and visible?
      meetings = results.map(&:id).each_with_object([]) do |raw_meeting_id, meetings|
        meeting = Meeting.find_by(raw_meeting_id: raw_meeting_id)
        meetings << meeting.id
        expect(meeting.visible?).to be_truthy
      end

      # 2 - are the remaining meetings without a raw meeting or not visible?
      remainder = Meeting.where.not(id: meetings)

      remainder.each do |meeting|
        okay = !meeting.visible? || !meeting.raw_meeting_id
        expect(okay).to be_truthy
      end


    end
  end
end
