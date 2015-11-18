require 'rails_helper'

RSpec.describe MeetingCreator do
  fixtures :raw_meetings

  context "with parenthetical location description and minimal codes" do
    before do
      allow_any_instance_of(Meeting).to receive(:calculated_zip).and_return("12345")
      mc = MeetingCreator.new(RawMeeting.first)
      @meeting = mc.create
    end

    it "extracts city" do
      expect(@meeting.city).to eq(RawMeeting.first[:city])
    end

    it "extracts first line address" do
      expect(@meeting.address_1).to eq("3355 S. Wadsworth Bl. #H-127")
    end

    it "knows open status" do
      expect(@meeting.closed).to eq(false)
    end

    it "converts time to decimal" do
      expect(@meeting.time).to eq(7.5)
    end

  end
end