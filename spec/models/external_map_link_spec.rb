require 'rails_helper'

RSpec.describe ExternalMapLink do
  fixtures :meetings, :addresses

  it "creates url based on lat and long" do
    meeting = Meeting.where(group_name: "Keeping It Simple").first
    expect(meeting.address.lat).to eq(39.650253)
    expect(meeting.address.lng).to eq(-104.977313)

    actual = ExternalMapLink.new(meeting).url
    expected = "http://maps.google.com/maps?q=loc:39.650253,-104.977313"

    expect(actual).to eq(expected)
  end
end