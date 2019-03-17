require 'rails_helper'

describe MeetingCreator::TraditionsExtractor do
  it "finds traditions" do
    raw_meeting = OpenStruct.new(codes: 'T')

    result = described_class.extract(raw_meeting)

    expect(result).to be_truthy
  end

  it "does not find traditions in ST" do
    raw_meeting = OpenStruct.new(codes: 'ST')

    result = described_class.extract(raw_meeting)

    expect(result).to be_falsey
  end
end
