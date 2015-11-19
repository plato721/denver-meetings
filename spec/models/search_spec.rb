require 'rails_helper'

RSpec.describe Search do
  fixtures :meetings

  it "finds by location" do
    search = Search.new({lat: 39.740143,
                         lng: -104.962335,
                         here: true})

    closest_meeting = search.results.first.last.first
    # (first group, associated meetings, first of the associated meetings)
    expect(closest_meeting.address.include?("1311 York")).to be_truthy
  end

  it "finds by name" do
    search = Search.create(group_text: "daily")

    expected = "Daily Serenity"
    actual = search.results.first.last.first.group_name

    expect(actual).to eq(expected)
  end
end