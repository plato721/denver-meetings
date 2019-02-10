require 'rails_helper'

RSpec.describe MeetingCreator::Format, type: :model do
  include_context "codes"

  it "has all formats" do
    format = [:speaker, :step, :big_book, :grapevine,
      :traditions, :candlelight, :beginners]
    found_formats = described_class.get_formats("")

    format.each do |format|
      expect(found_formats.keys.include? format).to be_truthy
    end
  end

  it "finds grapevine" do
    raw_code = "GV"
    formats = described_class.get_formats(raw_code)

    expect(formats[:grapevine]).to be_truthy
    formats.delete :grapevine
    expect(formats.values.any? { |f| f == true }).to be_falsey
  end

  it "does not give beginner false positive with BB" do
    raw_code = "BB"
    formats = described_class.get_formats(raw_code)

    expect(formats[:beginner]).to be_falsey
  end

  it "finds traditions" do
    raw_code = "T"
    formats = described_class.get_formats(raw_code)

    expect(formats[:traditions]).to be_truthy
    formats.delete :traditions
    expect(formats.values.any? { |f| f == true }).to be_falsey
  end

  it "does not find traditions in ST" do
    raw_code = "ST"
    formats = described_class.get_formats(raw_code)

    expect(formats[:step]).to be_truthy
    formats.delete :step
    expect(formats.values.any? { |f| f == true }).to be_falsey
  end

  it "finds with other codes" do
    raw_code = "BBBSTTC"
    formats = described_class.get_formats(raw_code)

    expected_names = [:big_book, :beginners, :step, :traditions]

    expected_names.each do |name|
      expect(formats[name]).to be_truthy
    end
  end
end
