require 'rails_helper'

RSpec.describe Feature, type: :model do
  include_context "codes"

  it "has all the features" do

    features = [:asl, :accessible, :non_smoking, :sitter]

    found_features = Feature.get_features("")

    features.each do |feature|
      expect(found_features.include? feature).to be_truthy
    end
  end

  context "parses from aggregate code" do

    it "finds ASL" do
      raw_code = "ASL"
      features = Feature.get_features(raw_code)

      expect(features.delete :asl).to be_truthy
      expect(features.values.reduce(&:|)).to be_falsey
    end

    it "finds accessible" do
      raw_code = "*nFrnSp"
      features = Feature.get_features(raw_code)

      expect(features.delete(:accessible)).to be_truthy
      expect(features.delete(:non_smoking)).to be_truthy

      expect(features.values.reduce(&:|)).to be_falsey
    end

    it "finds non-smoking" do
      raw_code = "n"
      features = Feature.get_features(raw_code)

      expect(features.delete :non_smoking).to be_truthy
      expect(features.values.reduce(&:|)).to be_falsey
    end

    it "does not give non-smoking false positive with Spn" do
      raw_code = "Spn"
      features = Feature.get_features(raw_code)

      expect(features.delete :non_smoking).to be_falsey
      expect(features.values.reduce(&:|)).to be_falsey
    end

    it "does not give non-smoking false positive with Frn" do
      raw_code = "Frn"
      features = Feature.get_features(raw_code)

      expect(features.delete :non_smoking).to be_falsey
      expect(features.values.reduce(&:|)).to be_falsey
    end

    it "finds sitter" do
      raw_code = "Sit"
      features = Feature.get_features(raw_code)

      expect(features.delete :sitter).to be_truthy
      expect(features.values.reduce(&:|)).to be_falsey
    end

    it "finds with other codes" do
      raw_code = "*nFrnSp"
      features = Feature.get_features(raw_code)

      expect(features.delete :accessible).to be_truthy
      expect(features.delete :non_smoking).to be_truthy
      expect(features.values.reduce(&:|)).to be_falsey
    end

  end
end
