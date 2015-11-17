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

  it "allows only valid foci" do
    bad_foci = Focus.new(code: "G", name: "German")

    expect(bad_foci).to_not be_valid
  end

  context "does not allow duplicate" do
    before do
      @code_foci = valid_foci.first
      @attributes = [:code, :name].zip(@code_foci).to_h

      Focus.create(@attributes)
    end

    it "code" do
      attributes = {code: @code_foci.first,
        name: valid_foci["Y"].last}

      dup = Focus.new(attributes)

      expect(dup).to_not be_valid
    end

    it "focus" do
      attributes = {code: valid_foci["W"].first,
        name: @code_foci.last}

      dup = Focus.new(attributes)

      expect(dup).to_not be_valid
    end
  end

  context "parses from aggregate code" do

    it "finds men" do
      raw_code = "M"
      foci = Focus.get_foci(raw_code)

      expect(foci.count).to eq(1)
      expect(foci.first.name).to eq("Men")
    end

    it "finds women" do
      raw_code = "W"
      foci = Focus.get_foci(raw_code)
      foci = foci.map { |f| f.name }

      expect(foci.count).to eq(1)
      expect(foci.include?("Women")).to be_truthy
    end

    it "finds gay" do
      raw_code = "G"
      foci = Focus.get_foci(raw_code)

      expect(foci.first.name).to eq("Gay")
    end

    it "does not give gay false positive with GV" do
      raw_code = "GV"
      foci = Focus.get_foci(raw_code)

      expect(foci.empty?).to be_truthy
    end

    it "finds young people" do
      raw_code = "Y"
      foci = Focus.get_foci(raw_code)

      expect(foci.first.name).to eq("Young People")
    end

  end
end
