require "rails_helper"

describe Address do
  context "validations" do
    it "is unique across address_1, address_2, city, state, and notes" do
      attributes = {
        address_1: "142 Buckeye Dr.",
        city: "Colorado Springs",
        state: "CO"
      }
      address = described_class.new(attributes)
      expect(address).to be_valid

      address.save!
      expect(described_class.new(attributes)).to_not be_valid
    end
  end

  context "associations" do
    it "has many meetings" do
      meetings = FactoryBot.create_list :meeting, 2
      address = FactoryBot.create :address
      address.meetings << meetings
      expect(address.meetings).to match_array(meetings)
    end
  end
end
