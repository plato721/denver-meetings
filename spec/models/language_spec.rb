require 'rails_helper'

RSpec.describe Language, type: :model do
  include_context "codes"

  it "has all the languages" do
    languages = [:french, :polish, :spanish]

    found_languages = Language.get_languages ""

    languages.each do |language|
      expect(found_languages.keys.include? language).to be_truthy
    end
  end

  context "parses from aggregate code" do

    it "finds french" do
      raw_code = "Frn"
      languages = Language.get_languages(raw_code)

      expect(languages.delete(:french)).to be_truthy
      expect(languages.values.reduce(&:|)).to be_falsey
    end

    it "finds spanish" do
      raw_code = "Spn"
      languages = Language.get_languages(raw_code)

      expect(languages.delete(:spanish)).to be_truthy
      expect(languages.values.reduce(&:|)).to be_falsey
    end

    it "finds polish" do
      raw_code = "Pol"
      languages = Language.get_languages(raw_code)

      expect(languages.delete(:polish)).to be_truthy
      expect(languages.values.reduce(&:|)).to be_falsey
    end

    it "finds with other codes" do
      raw_code = "*nFrnSp"
      languages = Language.get_languages(raw_code)

      expect(languages.delete(:french)).to be_truthy
      expect(languages.values.reduce(&:|)).to be_falsey
    end

  end
end
