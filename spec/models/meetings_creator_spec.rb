require 'rails_helper'

RSpec.describe MeetingsCreator do
  before :all do
    Meeting.destroy_all
    RawMeeting.destroy_all
    FactoryGirl.create_list :raw_meeting, 3
  end

  before :each do
    no_geocode
    @raw_meetings = RawMeeting.all
    @creator = MeetingsCreator.new(@raw_meetings, 0.0)
  end

  after :all do
    Meeting.destroy_all
    RawMeeting.destroy_all
  end

  it "creates meetings" do
    expect(Meeting.count).to eq(0)

    @creator.run_updates

    expect(Meeting.count).to eq(@raw_meetings.count)
  end

  it "flags meetings for deletion" do
    @creator.run_updates
    initial_count = Meeting.where(visible: true).count

    # now run creator with a missing raw meeting. the collection
    #   of raw meetings will be first_or_create for every meeting
    #   on the target scraping site.
    target = @raw_meetings.to_a.pop
    @creator = MeetingsCreator.new(@raw_meetings, 0.0)
    @creator.run_updates

    expect(@creator.deleted.count).to eq(1)
    expect(@creator.deleted.first.raw_meeting).to eq(target)
    expect(Meeting.where(visible: true).count).to eq(initial_count - 1)
  end

  it "logs create" do
    #initialized with 3, 3 created, 0 deleted, 0 untouched
    expect(Rails.logger).to receive(:info).with(/.*3 raw meetings.*/)
    expect(Rails.logger).to receive(:info).with(/.*3.*created.*/)
    expect(Rails.logger).to receive(:info).with(/.*0.*deleted.*/)
    expect(Rails.logger).to receive(:info).with(/.*0.*untouched.*/)
    @creator.run_updates
  end

  it "logs delete" do
    @creator.run_updates
    expect(Meeting.count).to eq(RawMeeting.count)

    @creator = MeetingsCreator.new([], 0)
    expect(Rails.logger).to receive(:info).with(/.*0 raw meetings.*/)
    expect(Rails.logger).to receive(:info).with(/.*0.*created.*/)
    expect(Rails.logger).to receive(:info).with(/.*3.*deleted.*/)
    expect(Rails.logger).to receive(:info).with(/.*0.*untouched.*/)
    @creator.run_updates
  end

  it "logs combo" do
    rm = RawMeeting.all.to_a
    @creator.run_updates

    Meeting.last.destroy
    rm.delete_at(0)

    @creator = MeetingsCreator.new(rm)
    expect(Rails.logger).to receive(:info).with(/.*2 raw meetings.*/)
    expect(Rails.logger).to receive(:info).with(/.*1.*created.*/)
    expect(Rails.logger).to receive(:info).with(/.*1.*deleted.*/)
    expect(Rails.logger).to receive(:info).with(/.*1.*untouched.*/)
    @creator.run_updates
  end
end