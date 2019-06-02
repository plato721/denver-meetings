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

  context "geocoding" do
    context "#geocoded?" do
      it "is not geocoded if there is no longitude" do
        no_lng = FactoryBot.create(:address, lat: 42, lng: nil)
        expect(no_lng.geocoded?).to be_falsey
      end

      it "is not geocoded if there is no latitude" do
        no_lat = FactoryBot.create(:address, lat: nil, lng: -109.9)
        expect(no_lat.geocoded?).to be_falsey
      end

      it "is geocoded if there is both lat and lng" do
        geod = FactoryBot.create(:address, lat: 42, lng: -109.9)
        expect(geod.geocoded?).to be_truthy
      end

      it "is not geocoded if there is not lat and lng" do
        neither = FactoryBot.create(:address, lat: nil, lng: nil)
        expect(neither.geocoded?).to be_falsey
      end
    end

    context "#geocode_with_reverse" do
      it "is geocodable" do
        # are we using the gem
        expect(subject).to respond_to(:geocode)
      end

      it "get_and_store_zip" do
        no_geocoding
        sut = FactoryBot.create(:address, lat: 40, lng: -109, zip: nil)

        sut.get_and_store_zip

        expect(sut.zip).to eq("80003")
      end
    end
  end
end
