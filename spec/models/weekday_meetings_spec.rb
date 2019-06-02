require 'rails_helper'

RSpec.describe WeekdayMeetings do
  fixtures :meetings, :addresses

  let(:days) { Day.day_order }
  before(:all) { @meetings = Meeting.all }

  it "groups meetings with day" do
    list = WeekdayMeetings.new(@meetings)

    list.each do |meeting|
      expect(days.include?(meeting.first.to_s)).to be_truthy
    end
  end

  it "returns displayable meetings in its list" do
    list = WeekdayMeetings.new(@meetings)

    list.each do |meeting|
      expect(meeting.last.all? do |m|
        m.is_a? MobileMeetingDisplay
      end).to be_truthy
    end
  end

  it "returns an enumerable result even if there are no meetings" do
    list = WeekdayMeetings.new([])

    expect(list.respond_to?(:each)).to be_truthy
  end
end