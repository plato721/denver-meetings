require 'rails_helper'

describe Meeting::ExtractPhone do
  it 'extracts a trailing phone number' do
    address_1 = "8250 W. 80th Ave. Unit 12, 303-420-6560"
    address = FactoryBot.build(:address, address_1: address_1)
    meeting = FactoryBot.create :meeting, address: address

    described_class.extract! meeting

    expect(meeting.address.address_1).to eql('8250 W. 80th Ave. Unit 12')
    expect(meeting.phone).to eql('303-420-6560')
    expect(meeting.changed?).to be_falsey
  end

  it 'extracts a seven digit phone number' do
    address_1 = "3355 S. Wadsworth #H125, 989-2816"
    address = FactoryBot.build(:address, address_1: address_1)
    meeting = FactoryBot.create :meeting, address: address

    described_class.extract! meeting

    expect(meeting.address.address_1).to eql('3355 S. Wadsworth #H125')
    expect(meeting.phone).to eql('989-2816')
    expect(meeting.changed?).to be_falsey
  end
end
