require 'rails_helper'

RSpec.describe Focus, type: :model do
  include_context "codes"

  it "gives result for each foci" do
    needed_foci = [:men, :women, :gay, :young_people]
    raw_code = ""

    foci = Focus.get_foci(raw_code)

    needed_foci.each do |focus|
      expect(foci.include? focus).to be_truthy
    end
  end

  context "parses from aggregate code" do

    it "finds men" do
      raw_code = "M"
      foci = Focus.get_foci(raw_code)

      expect(foci[:men]).to be_truthy

      foci.delete(:men)
      expect(foci.values.any? { |x| x == true }).to be_falsey
    end

    it "finds women" do
      raw_code = "W"
      foci = Focus.get_foci(raw_code)

      expect(foci[:women]).to be_truthy

      foci.delete(:women)
      expect(foci.values.any? { |x| x == true }).to be_falsey
    end

    it "finds gay" do
      raw_code = "G"
      foci = Focus.get_foci(raw_code)

      expect(foci[:gay]).to be_truthy

      foci.delete(:gay)
      expect(foci.values.any? { |x| x == true }).to be_falsey
    end

    it "does not give gay false positive with GV" do
      raw_code = "GV"
      foci = Focus.get_foci(raw_code)

      expect(foci.values.any? { |x| x == true }).to be_falsey
    end

    it "finds young people" do
      raw_code = "Y"
      foci = Focus.get_foci(raw_code)

      expect(foci[:young_people]).to be_truthy

      foci.delete(:young_people)
      expect(foci.values.any? { |x| x == true }).to be_falsey
    end

  end
end
