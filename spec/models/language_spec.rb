require 'rails_helper'

RSpec.describe Language, type: :model do
  include_context "codes"
  let(:valid_languages) do
    {"Spn" => "Spanish",
     "Frn" => "French",
     "Pol" => "Polish"}
  end

  it "can be created with a valid language" do
    code_lang = valid_languages.first
    attributes = [:code, :name].zip(code_lang).to_h

    count = Language.count
    Language.create(attributes)

    expect(Language.count).to eq(count + 1)
  end

  it "allows only valid languages" do
    bad_lang = Language.new(code: "G", name: "German")

    expect(bad_lang).to_not be_valid
  end

  context "does not allow duplicate" do
    before do
      @code_lang = valid_languages.first
      @attributes = [:code, :name].zip(@code_lang).to_h

      Language.create(@attributes)
    end

    it "code" do
      attributes = {code: @code_lang.first,
        name: valid_languages["Frn"].last}

      dup = Language.new(attributes)

      expect(dup).to_not be_valid
    end

    it "language" do
      attributes = {code: valid_languages["Frn"].first,
        name: @code_lang.last}

      dup = Language.new(attributes)

      expect(dup).to_not be_valid
    end
  end

  context "parses from aggregate code" do

    it "finds french" do
      raw_code = "Frn"
      languages = Language.get_languages(raw_code)

      expect(languages.count).to eq(1)
      expect(languages.first.name).to eq("French")
    end

    it "finds spanish" do
      raw_code = "Spn"
      languages = Language.get_languages(raw_code)

      expect(languages.count).to eq(1)
      expect(languages.first.name).to eq("Spanish")
    end

    it "finds polish" do
      raw_code = "Pol"
      languages = Language.get_languages(raw_code)

      expect(languages.first.name).to eq("Polish")
    end

    it "finds with other codes" do
      raw_code = "*nFrnSp"
      languages = Language.get_languages(raw_code)

      expect(languages.first.name).to eq("French")
    end

  end
end
