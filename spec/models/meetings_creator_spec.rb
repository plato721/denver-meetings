require 'rails_helper'

RSpec.describe MeetingsCreator do
  fixtures :raw_meetings

  it "creates meetings" do
    allow_any_instance_of(Meeting).to receive(:geocode).and_return(nil)

    raw_meetings = RawMeeting.all.to_a
    Meeting.destroy_all

    expect(Meeting.count).to eq(0)

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