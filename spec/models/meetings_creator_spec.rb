require 'rails_helper'

RSpec.describe MeetingsCreator do
  fixtures :raw_meetings

  xit "creates meetings" do
    allow_any_instance_of(Meeting).to receive(:geocode).and_return(nil)

    raw_meetings = RawMeeting.all
    RawMeeting.all(&:destroy)
    Meeting.all(&:destroy)

    # not working failing here. yes on eq 0. yes after destroying all.
    #   i was thinking it would fail due to interdependency betwen
    #   meeting / raw meeting. didn't see that error but perhaps still is cause
    expect(Meeting.count).to eq(0)
    expect(raw_meetings.count > 0).to be_truthy

    creator = MeetingsCreator.new(raw_meetings)
    creator.create_displayable

    expect(Meeting.count).to eq(raw_meetings.count)
  end

  it "flags meetings for deletion" do
    allow_any_instance_of(Meeting).to receive(:geocode).and_return(nil)
    raw_meetings = RawMeeting.all

    mc = MeetingsCreator.new(raw_meetings)
    mc.create_displayable
    initial_count = Meeting.where(visible: true).count

    raw_meetings = raw_meetings.to_a
    target = raw_meetings.pop

    mc = MeetingsCreator.new(raw_meetings)
    tag_delete = mc.perform_soft_delete

    expect(tag_delete.count).to eq(1)
    expect(tag_delete.first).to eq(Meeting.find_by(raw_meeting_id: target.id))
    expect(Meeting.where(visible: true).count).to eq(initial_count - 1)
  end
end