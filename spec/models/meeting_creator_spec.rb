require 'rails_helper'

RSpec.describe MeetingCreator do
  fixtures :raw_meetings

  context "with parenthetical location description and minimal codes" do
    before :each do
      allow_any_instance_of(Meeting).to receive(:geocode).and_return(nil)
      @rm = RawMeeting.where(RawMeeting.arel_table[:address].matches('%3355 S.%')).first
      mc = MeetingCreator.new(@rm)
      @meeting = mc.create
    end

    it "extracts city" do
      expect(@meeting.city).to eq(@rm.city)
    end

    it "extracts first line address" do
      expect(@meeting.address_1).to eq("3355 S. Wadsworth Bl. #H-127")
    end

    it "knows open status" do
      expect(@meeting.closed?).to eq(false)
    end

    it "converts time to decimal" do
      expect(@meeting.time).to eq(7.5)
    end
  end

  context "with non-spaced parenthetical location description" do
    before :all do
      @raw = RawMeeting.create(
        day: 'Tuesday',
        group_name: "Men's Meeting",
        address: "1200 South St.(Ch bsmt #104)",
        city: 'Castle Rock',
        district: '10',
        codes: 'CMn'
      )
    end

    before :each do
      allow_any_instance_of(Meeting).to receive(:geocode).and_return(nil)
      @mc = MeetingCreator.new(@raw)
      # @meeting = mc.create
    end

    it "parses address_1" do
      expect(@mc.address_1).to eql("1200 South St.")
    end

    it "parses notes" do
      expect(@mc.notes).to eql("Ch bsmt #104")
    end
  end

  context "with phone number" do
    before :all do
      @raw = RawMeeting.create(
        group_name: "A New Day",
        address: "8250 W. 80th Ave. Unit 12, 303-420-6560",
      )
      @mc = MeetingCreator.new(@raw)
    end

    it "parses address_1" do
      expect(@mc.address_1).to eql("8250 W. 80th Ave. Unit 12")
    end

    it "parses notes" do
      expect(@mc.notes).to_not be_present
    end

    it "parses phone number" do
      expect(@mc.phone).to eql("303-420-6560")
    end
  end
end
