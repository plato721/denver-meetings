require 'rails_helper'

describe MeetingCreator::FrenchExtractor do
  it "finds with other codes" do
    raw_meeting = OpenStruct.new(codes: '*nFrnSp')

    result = described_class.extract(raw_meeting, nil)

    expect(result).to be_truthy
  end
end
