require 'rails_helper'

RSpec.describe Search do
  before :all do
    Meeting.destroy_all
    FactoryGirl.create_list :meeting, 5, _skip_geocoder: true

    Meeting.first.update_attribute(:lat, 39.740143)
    Meeting.first.update_attribute(:lng, -104.962335)

    Meeting.second.update_attribute(:group_name, "Mojo Jojo's House of Dojo")
    Meeting.third.update_attribute(:city, "Townsxyzpdq1234villia")
  end

  it "finds by location" do
    search = Search.new({lat: 39.740132,
                         lng: -104.962323,
                         here: true})

    closest_meeting = search.results.first.last.first
    # (first group, associated meetings, first of the associated meetings)
    expect(closest_meeting.group_name).to eq(Meeting.first.group_name)
  end

  it "finds by group name free text" do
    search = Search.create(free: "jojo")

    expected = Meeting.second.group_name
    actual = search.results.first.last.first.group_name

    expect(actual).to eq(expected)
  end

  context "open/closed" do
    before do
      Meeting.fourth.update_attribute(:closed, true)
      Meeting.second.update_attribute(:closed, false)
      Meeting.fifth.update_attribute(:closed, nil)
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