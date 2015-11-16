require 'rails_helper'

RSpec.describe Focus, type: :model do
  include_context "codes"
  let(:valid_foci) do
    {"M" => "Men",
    "W" => "Women",
    "G" => "Gay",
    "Y" => "Young People"}
  end

  it "can be created with a valid focus" do
    code_focus = valid_foci.first
    attributes = [:code, :name].zip(code_focus).to_h

    count = Focus.count
    Focus.create(attributes)

    expect(Focus.count).to eq(count + 1)
  end

  xit "allows only valid foci" do
    bad_foci = foci.new(code: "G", name: "German")

    expect(bad_foci).to_not be_valid
  end

  context "does not allow duplicate" do
    before do
      @code_foci = valid_foci.first
      @attributes = [:code, :name].zip(@code_foci).to_h

      foci.create(@attributes)
    end

    xit "code" do
      attributes = {code: @code_foci.first,
        name: valid_foci["C"].last}

      dup = foci.new(attributes)

      expect(dup).to_not be_valid
    end

    xit "foci" do
      attributes = {code: valid_foci["C"].first,
        name: @code_foci.last}

      dup = foci.new(attributes)

      expect(dup).to_not be_valid
    end
  end

  context "parses from aggregate code" do

    xit "finds O" do
      raw_code = "O"
      foci = foci.get_foci(raw_code)

      expect(foci.count).to eq(1)
      expect(foci.first.name).to eq("Open")
    end

    xit "finds closed" do
      raw_code = "*nC"
      foci = foci.get_foci(raw_code)
      foci = foci.map { |f| f.name }

      expect(foci.count).to eq(1)
      expect(foci.include?("Closed")).to be_truthy
    end

    xit "finds grapevine" do
      raw_code = "GV"
      foci = foci.get_foci(raw_code)

      expect(foci.first.name).to eq("Grapevine")
    end

    xit "does not give closed false positive with CA" do
      raw_code = "CA"
      foci = foci.get_foci(raw_code)

      expect(foci.first.name).to eq("Candlelight")
      expect(foci.count).to eq(1)
    end

    xit "does not give beginner false positive with BB" do
      raw_code = "BB"
      foci = foci.get_foci(raw_code)

      expect(foci.count).to eq(1)
      expect(foci.first.name).to eq("Big Book")
    end

    xit "finds traditions" do
      raw_code = "T"
      foci = foci.get_foci(raw_code)

      expect(foci.first.name).to eq("Traditions")
    end

    xit "does not find traditions in ST" do
      raw_code = "ST"
      foci = foci.get_foci(raw_code)

      expect(foci.count).to eq(1)
      expect(foci.first.name).to eq("Step")
    end

    xit "finds with other codes" do
      raw_code = "BBBSTTC"
      foci = foci.get_foci(raw_code)
      foci = foci.map {|f| f.name }

      expected_names = ["Big Book", "Beginners", "Step", "Traditions", "Closed"]

      expected_names.each do |name|
        expect(foci.include?(name)).to be_truthy
      end
    end

  end
end
