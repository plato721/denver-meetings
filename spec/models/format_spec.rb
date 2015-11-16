require 'rails_helper'

RSpec.describe Format, type: :model do
  include_context "codes"
  let(:valid_formats) do
    { "O" => "Open",
    "C" => "Closed",
    "SP" => "Speaker",
    "ST" => "Step",
    "BB" => "Big Book",
    "GV" => "Grapevine",
    "T" => "Traditions",
    "CA" => "Candlelight",
    "B" => "Beginners"}
  end

  it "can be created with a valid format" do
    code_format = valid_formats.first
    attributes = [:code, :name].zip(code_format).to_h

    count = Format.count
    Format.create(attributes)

    expect(Format.count).to eq(count + 1)
  end

  it "allows only valid formats" do
    bad_format = Format.new(code: "G", name: "German")

    expect(bad_format).to_not be_valid
  end

  context "does not allow duplicate" do
    before do
      @code_format = valid_formats.first
      @attributes = [:code, :name].zip(@code_format).to_h

      Format.create(@attributes)
    end

    it "code" do
      attributes = {code: @code_format.first,
        name: valid_formats["C"].last}

      dup = Format.new(attributes)

      expect(dup).to_not be_valid
    end

    it "format" do
      attributes = {code: valid_formats["C"].first,
        name: @code_format.last}

      dup = Format.new(attributes)

      expect(dup).to_not be_valid
    end
  end

  context "parses from aggregate code" do

    it "finds O" do
      raw_code = "O"
      formats = Format.get_formats(raw_code)

      expect(formats.count).to eq(1)
      expect(formats.first.name).to eq("Open")
    end

    it "finds closed" do
      raw_code = "*nC"
      formats = Format.get_formats(raw_code)
      formats = formats.map { |f| f.name }

      expect(formats.count).to eq(1)
      expect(formats.include?("Closed")).to be_truthy
    end

    it "finds grapevine" do
      raw_code = "GV"
      formats = Format.get_formats(raw_code)

      expect(formats.first.name).to eq("Grapevine")
    end

    it "does not give closed false positive with CA" do
      raw_code = "CA"
      formats = Format.get_formats(raw_code)

      expect(formats.first.name).to eq("Candlelight")
      expect(formats.count).to eq(1)
    end

    it "does not give beginner false positive with BB" do
      raw_code = "BB"
      formats = Format.get_formats(raw_code)

      expect(formats.count).to eq(1)
      expect(formats.first.name).to eq("Big Book")
    end

    it "finds traditions" do
      raw_code = "T"
      formats = Format.get_formats(raw_code)

      expect(formats.first.name).to eq("Traditions")
    end

    it "does not find traditions in ST" do
      raw_code = "ST"
      formats = Format.get_formats(raw_code)

      expect(formats.count).to eq(1)
      expect(formats.first.name).to eq("Step")
    end

    it "finds with other codes" do
      raw_code = "BBBSTTC"
      formats = Format.get_formats(raw_code)
      formats = formats.map {|f| f.name }

      expected_names = ["Big Book", "Beginners", "Step", "Traditions", "Closed"]

      expected_names.each do |name|
        expect(formats.include?(name)).to be_truthy
      end
    end

  end
end
