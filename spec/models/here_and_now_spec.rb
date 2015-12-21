require 'rails_helper'

RSpec.describe HereAndNow do
  fixtures :meetings

  before do
    @lat = 39.7402592
    @lng = -104.962609399
  end

  it "returns meetings within three hours sorted by distance" do
    allow(Time).to receive(:current).and_return(Time.new(2015,11,17,19,00,0))
    meetings = HereAndNow.new({lat: @lat, lng: @lng}).search

    expect(meetings.first.first).to eq("Within 1 mile")
    expect(meetings.first.second.first.group_name).to eq("Daily Serenity")
  end
  
end