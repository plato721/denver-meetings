require 'rails_helper'

RSpec.describe Proximal do
  let(:my_coords) {[39.740143, -104.962335]}

  before :all do
    FactoryGirl.create_list :meeting, 3
    Meeting.first.update_attribute(:lat, 39.736960)
    Meeting.first.update_attribute(:lng, -104.959935)
    Meeting.first.update_attribute(:group_name, "Daily Serenity")
  end

  after :all do
    Meeting.destroy_all
  end

  it "calculates the distance between a location and a meeting" do
    no_geocode
    meeting = Meeting.find_by(group_name: "Daily Serenity")

    prox = Proximal.new(meeting)

    actual = prox.distance_from(my_coords).round(3)
    expected = 0.254

    expect(actual).to eq(expected)
  end

  it "calculates closest x meetings" do
    actual = Proximal.nearest(1, my_coords).first.first

    expect(actual.id).to eq(Meeting.first.id)
  end
end