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

  xit "finds by name" do
    search = Search.create(@search_params.merge(group_name: "keep"))

    expected = "Keeping It Simple"
    actual = search.results.first.last.first.group_name

    expect(actual).to eq(expected)
  end
end