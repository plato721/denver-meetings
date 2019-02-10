require 'rails_helper'

RSpec.describe MobileMeetingDisplay do
  before :all do
    FactoryBot.create_list :meeting, 3
  end

  after :all do
    Meeting.destroy_all
  end

  it "rounds numbers" do
    distance = 5.23892342
    distance_2 = 5.2938428

    mmd = MobileMeetingDisplay.new(Meeting.first, distance)
    mmd2 = MobileMeetingDisplay.new(Meeting.first, distance_2)

    expect(mmd.distance).to eq("5.2")
    expect(mmd2.distance).to eq("5.3")
  end

  it "determines integer day of week" do
    Meeting.first.update_attribute(:day, "Sunday")

    mmd = MobileMeetingDisplay.new(Meeting.first)

    expect(mmd.raw_day).to eq(0)
  end

  it "knows if a meeting is approved" do
    Meeting.first.update_attribute(:approved, true)
    mmd = MobileMeetingDisplay.new(Meeting.first)

    expect(mmd.approved?).to be_truthy
  end

  it "access meeting notes" do
    new_notes = "old cabin"
    Meeting.first.update_attribute(:notes, new_notes)
    mmd = MobileMeetingDisplay.new(Meeting.first)

    expect(mmd.notes).to eq(new_notes)
  end

  it "has meeting phone number" do
    phone = "719-528-1021"
    Meeting.first.update_attribute(:phone, phone)
    mmd = MobileMeetingDisplay.new(Meeting.first)

    expect(mmd.phone).to eq(phone)
  end

  it "has meeting coords" do
    lat = Meeting.first.lat
    lng = Meeting.first.lng
    mmd = MobileMeetingDisplay.new(Meeting.first)

    expect(mmd.coords).to eq("#{lat}, #{lng}")
  end

  it "knows if a meeting is open/closed" do
    mmd = MobileMeetingDisplay.new(Meeting.first)

    expect(mmd.respond_to? :closed?).to be_truthy
  end
end