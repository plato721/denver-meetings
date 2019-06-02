require 'rails_helper'

RSpec.describe Meeting, type: :model do
  include_context "codes"

  before :all do
    Meeting.destroy_all
    FactoryBot.create_list :meeting, 3
  end

  after :all do
    Meeting.destroy_all
  end

  context "associations" do
    it "has an address" do
      address = FactoryBot.create :address
      meeting = FactoryBot.create :meeting

      meeting.address = address
      meeting.save

      expect(meeting.address).to eql(address)
    end
  end

  it "is visible by default" do
    meeting = Meeting.first

    expect(meeting.visible?).to be_truthy
  end

  context "scopes" do
    it "- visible shows visible meetings" do
      meeting = Meeting.first
      meeting.update_attribute(:visible, false)

      found = Meeting.visible
      expect(found.all? { |m| m.visible? }).to be_truthy
      expect(found.count).to eq(Meeting.count - 1)
    end

    it "- open meetings are those that aren't closed" do
      expect(Meeting.open.count).to eq(Meeting.count)
      expect(Meeting.closed.count).to eq(0)

      Meeting.first.update_attribute(:closed, true)
      expect(Meeting.closed.count).to eq(1)
      expect(Meeting.open.count).to eq(Meeting.count - 1)
    end

    it "- address is used to know whether geocoded" do

    end


  end
end
