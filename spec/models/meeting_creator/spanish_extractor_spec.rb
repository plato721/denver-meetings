require 'rails_helper'

describe MeetingCreator::SpanishExtractor do
  it 'knows Sp is not Spanish' do
    raw_meeting = OpenStruct.new(codes: '*nFrnSp')

    result = described_class.extract(raw_meeting)

    expect(result).to be_falsey
  end
end
