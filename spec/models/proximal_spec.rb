require 'rails_helper'

RSpec.describe Proximal do
  fixtures :meetings
  let(:my_coords) {[39.740143, -104.962335]}

  it "calculates the distance between a location and a meeting" do
    meeting = meetings(:two)

    prox = Proximal.new(meeting)

    actual = prox.distance_from(my_coords).round(3)
    expected = 0.254

    expect(actual).to eq(expected)
  end

  it "calculates closest x meetings" do
    actual = Proximal.nearest(1, my_coords).first.first

    expect(actual.address_1.include?("1311 York")).to be_truthy
  end
end