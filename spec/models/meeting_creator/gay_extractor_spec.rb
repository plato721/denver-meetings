require 'rails_helper'

describe MeetingCreator::GayExtractor do
  it 'finds gay' do
    raw_meeting = OpenStruct.new( codes: 'G' )

    result = described_class.extract(raw_meeting)

    expect(result).to be_truthy
  end

  it 'does not give gay false positive with GV' do
    raw_meeting = OpenStruct.new( codes: 'GV' )

    result = described_class.extract(raw_meeting)

    expect(result).to be_falsey
  end
end
