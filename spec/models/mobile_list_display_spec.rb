require 'rails_helper'

RSpec.describe MobileListDisplay do
  fixtures :meetings

  let(:days) { SearchOptions.new.days }
  before(:all) { @meetings = Meeting.all }

  it "groups meetings with day" do
    list = MobileListDisplay.new(@meetings)

    list.each do |meeting|
      expect(days.include?(meeting.first)).to be_truthy
    end
  end

  it "returns displayable meetings in its list" do
    list = MobileListDisplay.new(@meetings)

    list.each do |meeting|
      expect(meeting.last.all? do |m|
        m.is_a? MobileMeetingDisplay
      end).to be_truthy
    end
  end

  it "returns an enumerable result even if there are no meetings" do
    list = MobileListDisplay.new([])

    expect(list.respond_to?(:each)).to be_truthy
  end
end