require 'rails_helper'

RSpec.describe ExternalMapLink do
  fixtures :meetings

  it "creates url based on lat and long" do
    expect(meetings(:one).lat).to eq(39.650253)
    expect(meetings(:one).lng).to eq(-104.977313)

    actual = ExternalMapLink.new(meetings(:one)).url
    expected = "http://maps.google.com/maps?q=loc:39.650253,-104.977313"

    expect(actual).to eq(expected)
  end
end