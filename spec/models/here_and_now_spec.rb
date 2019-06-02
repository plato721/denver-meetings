require 'rails_helper'

RSpec.describe HereAndNow do
  fixtures :meetings, :addresses

  before do
    @lat = 39.7402592
    @lng = -104.962609399
  end

  it "returns meetings within three hours sorted by distance" do
    allow(TimeConverter).to receive(:now_raw).and_return(Time.new(2015,11,17,19,00,0))
    meetings = HereAndNow.new({lat: @lat, lng: @lng}).search

    expect(meetings.first.first).to eq("Within 1 mile")
    expect(meetings.first.second.first.group_name).to eq("Daily Serenity")
  end

  context "morning meetings" do
    # TODO
    # it "no morning meetings are added if it's earlier than 7p" do
    #   allow(TimeConverter).to receive(:now_raw).and_return(Time.new(2015,11,17,18,59,0))

    #   # create some morning meetings. ensure they aren't in the results
    #   here_and_now = HereAndNow.new({lat: @lat, lng: @lng})

    #   expect(here_and_now.morning_meetings_needed?).to be_falsey
    # end

    # then another test here ensuring the meetings are added
  end
end