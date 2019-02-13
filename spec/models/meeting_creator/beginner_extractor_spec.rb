require 'rails_helper'

describe MeetingCreator::BeginnersExtractor do
  it 'does not give beginner false positive with BB' do
    raw_meeting = OpenStruct.new(codes: 'BB')

    result = described_class.extract(raw_meeting)

    expect(result).to be_falsey
  end
end
