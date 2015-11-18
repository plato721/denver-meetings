require 'rails_helper'

RSpec.describe Feature, type: :model do
  include_context "codes"
  let(:valid_features) do
    {"ASL" => "Sign Language Interpreter",
      "*" => "Accessible",
      "n" => "Non-Smoking",
    "Sit" => "Sitter"}
  end

  it "allows only valid Features" do
    bad_feature = Feature.new(code: "G", name: "German")

    expect(bad_feature).to_not be_valid
  end

  context "does not allow duplicate" do
    before do
      @code_feature = valid_features.first
      @attributes = [:code, :name].zip(@code_feature).to_h

      Feature.create(@attributes)
    end

    it "code" do
      attributes = {code: @code_feature.first,
        name: valid_features["Sit"].last}

      dup = Feature.new(attributes)

      expect(dup).to_not be_valid
    end

    it "Feature" do
      attributes = {code: valid_features["Sit"].first,
        name: @code_feature.last}

      dup = Feature.new(attributes)

      expect(dup).to_not be_valid
    end
  end

  context "parses from aggregate code" do

    it "finds ASL" do
      raw_code = "ASL"
      features = Feature.get_features(raw_code)

      expect(features.count).to eq(1)
      expect(features.first.name).to eq("Sign Language Interpreter")
    end

    it "finds accessible" do
      raw_code = "*nFrnSp"
      features = Feature.get_features(raw_code)
      features = features.map { |f| f.name }

      expect(features.count).to eq(2)
      expect(features.include?("Accessible")).to be_truthy
    end

    it "finds non-smoking" do
      raw_code = "n"
      features = Feature.get_features(raw_code)

      expect(features.first.name).to eq("Non-Smoking")
    end

    it "does not give non-smoking false positive with Spn" do
      raw_code = "Spn"
      features = Feature.get_features(raw_code)

      expect(features.empty?).to be_truthy
    end

    it "does not give non-smoking false positive with Frn" do
      raw_code = "Frn"
      features = Feature.get_features(raw_code)

      expect(features.empty?).to be_truthy
    end

    it "finds sitter" do
      raw_code = "Sit"
      features = Feature.get_features(raw_code)

      expect(features.first.name).to eq("Sitter")
    end

    it "finds with other codes" do
      raw_code = "*nFrnSp"
      features = Feature.get_features(raw_code)
      features = features.map {|f| f.name }

      expect(features.include?("Accessible")).to be_truthy
    end

  end
end
