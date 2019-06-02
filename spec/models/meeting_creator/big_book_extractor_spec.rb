require 'rails_helper'

describe MeetingCreator::BigBookExtractor do
  it 'finds in a group of codes' do
    raw_meeting = OpenStruct.new(codes: "BBBSTTC")

    result = described_class.extract(raw_meeting, nil)

    expect(result).to be_truthy
  end
end
