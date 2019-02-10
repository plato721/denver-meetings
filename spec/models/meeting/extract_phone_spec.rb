require 'rails_helper'
require Rails.root.join('./app/models/meeting/extract_phone.rb').to_s

describe ExtractPhone do
  it 'extracts a trailing phone number' do
    meeting = FactoryBot.create :meeting,
      address_1: "8250 W. 80th Ave. Unit 12, 303-420-6560"

    described_class.extract! meeting

    expect(meeting.address_1).to eql('8250 W. 80th Ave. Unit 12')
    expect(meeting.phone).to eql('303-420-6560')
    expect(meeting.changed?).to be_falsey
  end

  it 'extracts a seven digit phone number' do
    meeting = FactoryBot.create :meeting,
      address_1: "3355 S. Wadsworth #H125, 989-2816"

    described_class.extract! meeting

    expect(meeting.address_1).to eql('3355 S. Wadsworth #H125')
    expect(meeting.phone).to eql('989-2816')
    expect(meeting.changed?).to be_falsey
  end
end
