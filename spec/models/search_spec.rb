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

  it "finds by group name free text" do
    search = Search.create(group_text: "daily")

    expected = "Daily Serenity"
    actual = search.results.first.last.first.group_name

    expect(actual).to eq(expected)
  end

  it "finds by city name free text" do
    search = Search.create(city_text: "ake")

    expected = "Always Hope"
    actual = search.results.first.last.first.group_name

    expect(actual).to eq(expected)
  end

  context "open/closed" do
    before do
      # Meeting.first.update_attributes(closed: true)
      # Meeting.second.update_attributes(closed: false)
      # Meeting.third.update_attributes(closed: nil)
    end

    it "finds closed only" do
      search = Search.create(open: "closed")

      search.results.each do |group|
        group.last.each do |meeting|
          expect(meeting.closed?).to be_truthy
        end
      end
    end

    it "finds open only" do
      search = Search.create(open: "open")

      actual_name = search.results.each do |group|
        group.last.each do |meeting|
          expect(meeting.closed?).to be_falsey
        end
      end
    end
  end
end