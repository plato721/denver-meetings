require 'rails_helper'

describe MeetingCreator::GrapevineExtractor do
  it 'finds grapevine' do
    raw_meeting = OpenStruct.new(codes: 'GV')

    result = described_class.extract(raw_meeting)

    expect(result).to be_truthy
  end
end
