require 'rails_helper'

describe MeetingCreator::Address1Extractor do
  addresses_with_extracted = {
    '123 Fake St.' => '123 Fake St.',
    '3600 S. Clarkson (NE of Ch)' => '3600 S. Clarkson St.',
    '3355 S. Wadsworth #H125, 989-2816' => '3355 S. Wadsworth Blvd.',
    '8817 S. Broadway (Ch)' => '8817 S. Broadway',
    '1311 York St., 322-3674' => '1311 York St.',
    '5455 W. 38th Ave. Unit M' => '5455 W. 38th Ave.',
    '1801 Sunset Pl. Ste B' => '1801 Sunset Pl.',

    # testing no spaces before notes
    '10151 W. 26th Ave.(Restaurant)' => '10151 W. 26th Ave.',

    # ensuring Wadsworth Blvd. doesn't become Blvd. Blvd.
    '3355 S. Wadsworth Blvd. #H-125, 989-2816' => '3355 S. Wadsworth Blvd.',
    '7964 S. Depew (Platte Canyon/Chatfield)' => '7964 S. Depew St.',

    # yes, 3 different wadsworths
    '1050 Wadsworth Bl. 303-238-5693' => '1050 Wadsworth Blvd.',
    '147 S. 2nd Place, 303-659-9953' => '147 S. 2nd Place',
    '1200 South St.(Ch bsmt #104)' => "1200 South St.",

    '16732 E. Iliff (Shop. Ctr) 695-7766' => '16732 E. Iliff Ave.',
    '3489 W. 72nd (Rm 104)' => '3489 W. 72nd Ave.'

  }

  addresses_with_extracted.each do |address_in, expected_output|
    it "extracts #{expected_output} from #{address_in}" do
      raw_meeting = OpenStruct.new(address: address_in)

      result = described_class.extract(raw_meeting)

      expect(result).to eql(expected_output)
    end
  end
end
