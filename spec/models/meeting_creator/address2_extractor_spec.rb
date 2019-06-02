require 'rails_helper'

describe MeetingCreator::Address2Extractor do
  addresses_with_extracted = {
    '123 Fake St.' => '',
    '3600 S. Clarkson (NE of Ch)' => '',
    '3355 S. Wadsworth #H125, 989-2816' => '#H125',
    '8817 S. Broadway (Ch)' => '',
    '1311 York St., 322-3674' => '',
    '5455 W. 38th Ave. Unit M' => 'Unit M',
    '1801 Sunset Pl. Ste B' => 'Ste B',

    # testing no spaces before notes
    '10151 W. 26th Ave.(Restaurant)' => '',

    # a '#' with a dash
    '3355 S. Wadsworth Blvd. #H-125, 989-2816' => '#H-125',
    '147 S. 2nd Place, 303-659-9953' => '',
    '1200 South St.(Ch bsmt #104)' => '',
    '2525 W. Evans Ave. (Polish 882-1038)' => '',
  }

  addresses_with_extracted.each do |raw_address, desired_output|
    it "extracts '#{desired_output}' from '#{raw_address}'" do
      raw_meeting = OpenStruct.new(address: raw_address)

      result = described_class.extract(raw_meeting, nil)

      expect(result).to eql(desired_output)
    end
  end
end
