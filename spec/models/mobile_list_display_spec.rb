require 'rails_helper'

RSpec.describe MobileListDisplay do
  fixtures :meetings
  let(:days) { SearchOptions.new.days }

  it "groups meetings with day" do
    meetings = Meeting.all
    list = MobileListDisplay.new(meetings)

    list.each do |meeting|
      expect(days.include?(meeting.first)).to be_truthy
    end

  end
end