require 'rails_helper'

# Defining a fake attribute handler-- we don't want to mess the class up for
# tests that target these handlers specifically.
class MeetingCreator::SizeExtractor
  def self.extract(_raw_meeting, _)
    'Large'
  end
end

describe MeetingCreator::BuildAttributes do
  before :all do
    @fake_raw_meeting = OpenStruct.new(
      address: '123 Evergreen Terrace',
      color: 'Pink'
    )
  end

  it 'passes through the attribute if no handler is available' do
    ba = described_class.new(@fake_raw_meeting)
    allow(ba).to receive(:object_attributes).and_return(
      [:size, :color]
    )
    allow(described_class).to receive(:new).and_return(ba)


    attributes = described_class.build_from(@fake_raw_meeting)

    expect(defined? MeetingCreator::ColorExtractor).to be_falsey
    expect(attributes[:color]).to eq('Pink')
  end

  it 'uses custom handler if available' do
    ba = described_class.new(@fake_raw_meeting)
    allow(ba).to receive(:object_attributes).and_return(
      [:size, :color]
    )
    allow(described_class).to receive(:new).and_return(ba)
    allow(MeetingCreator::SizeExtractor).to receive(:extract)

    described_class.build_from(@fake_raw_meeting)

    expect(MeetingCreator::SizeExtractor).to have_received(:extract).exactly(1)
                                                                    .times
  end

  context 'determine handler - ' do
    it 'gets RawMeeting for :raw_meeting' do
      handler = described_class.new('x').determine_handler(:raw_meeting)
      expect(handler).to eql(MeetingCreator::RawMeetingExtractor)
    end
  end
end
