require 'rails_helper'

describe Meeting::Tasks::MoveAddressFromMeeting do
  before :all do
    @meeting = FactoryBot.create(:meeting)
  end

  it 'creates a meeting' do
    expect(@meeting.is_a? Meeting).to be_truthy
  end

  it 'moves the address' do
    # these are the components taken from the raw address field, hence
    # we'll store them in the same table, with a unique key of the
    # raw address
    address_components = [
      :address_1, :address_2, :city, :state, :zip, :phone, :notes
    ]
  end
end
