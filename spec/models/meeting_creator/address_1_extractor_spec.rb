require 'rails_helper'

describe MeetingCreator::Address1Extractor do
  addresses_with_extracted = {
    '123 Fake St.' => '123 Fake St.',
    '3600 S. Clarkson (NE of Ch)' => '3600 S. Clarkson St.',
    '3355 S. Wadsworth #H125, 989-2816' => '3355 S. Wadsworth Blvd.'
  }

  addresses_with_extracted.each do |address_in, expected_output|
    it "extracts #{expected_output} from #{address_in}" do
      raw_meeting = OpenStruct.new(address: address_in)
      result = described_class.extract(raw_meeting)

      expect(result).to eql(expected_output)
    end
  end
end
