  require "rails_helper"
  require "./lib/tasks/move_address/move_address"

  describe MoveAddress do
    let(:address_attributes) {
      { address_1: "555 Main Dr.",
        address_2: "#2",
        city: "Aurora",
        state: "CO",
        zip: "80017",
        notes: "On beach",
        lat: "40.504698",
        lng: "-104.977313"
      }
    }

    it "creates an address for a meeting" do
      expect(Address.find_by(address_attributes)).to be_falsey

      meeting = FactoryBot.create(:meeting, address_attributes)
      described_class.call(meeting)

      expect(Address.find_by(address_attributes)).to be_truthy
    end
  end
