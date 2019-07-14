class ScrubAddresses070219 < ActiveRecord::Migration[5.2]
  def change
    wads = Address.where('address_1 LIKE ?', '3355%')
    wads.update_all(lat: 39.6552663, lng: -105.0839885)

    awol_address = Address.find_by('address_1 LIKE ?', '3600 S. Clarkson St%')
    awol_meetings = Meeting.joins(:address).where('addresses.address_1 LIKE ?', '3600 %')
    awol_meetings.update_all(address_id: awol_address.id)

    depew_addresses = Address.where('address_1 LIKE ?', '7964%')
    depew_addresses.update_all(
      address_1: '7964 S. Depew St.',
      zip: 80128,
      lat: 39.5728201,
      lng: -105.058695
    )

    rr = Address.find_by(address_1: "Red Rocks Pavilion")
    rr&.update_attributes(
      district: 29,
      lat: 39.6678785,
      lng: -105.217956
    )

    pville = Address.where('address_1 LIKE ?', 'Main &%')
    pville.update_all(
      lat: 40.2160981,
      lng: -104.825435,
      zip: 80651,
      district: 34
    )

    bufpk73 = Address.where('address_1 LIKE ?', 'Hwy73/Buffalo Pk%')
    bufpk73.update_all(
      lat: 39.6237039,
      lng: -105.3295728,
      district: 29,
      zip: 80439
    )

    Address.where('address_1 LIKE ?', '9357 E. Colfax%').update_all(
      zip: 80010,
      lat: 39.7404364,
      lng: -104.881178
    )

    Address.where('address_1 LIKE ?', '9057 E. Colfax%').update_all(
      zip: 80010,
      lat: 39.7402838,
      lng: -104.8834974
    )

    Address.where('address_1 LIKE ?', '9203 S%').update_all(
      lat: 39.5474258,
      lng: -104.952533,
      district: 11,
      address_1: '9203 S University Blvd'
    )

    Address.where('address_1 LIKE ?', '8250 W%').update_all(
      address_1: '8250 W 80th Ave',
      address_2: 'Unit 12',
      zip: 80005,
      lat: 39.8408019,
      lng: -105.0917633,
      district: 31
    )

    Address.where('address_1 LIKE ?', '10270%').update_all(
      address_1: '10270 S Progress Way',
      address_2: '#B',
      lat: 39.5308252,
      lng: -104.7711065,
      zip: 80134,
      district: 10
    )

    #arid
    Address.where('address_1 LIKE ?', '1050 Wadsworth Bl%').update_all(
      lat: 39.7336782,
      lng: -105.0833035,
      zip: 80214,
      district: 12,
      address_1: '1050 Wadsworth Blvd'
    )

    Address.where('address_1 LIKE ?', '1100 Fil%').update_all(
      address_1: '1100 Fillmore St',
      lat: 39.7337996,
      lng: -104.9547234,
      zip: 80206,
      district: 13
    )

    Address.where('address_1 LIKE ?', '23 Inv%').update_all(
      address_1: '23 Inverness Way East',
      address_2: '#150',
      lat: 39.5667036,
      lng: -104.8621585,
      zip: 80012,
      district: 16
    )

    # fix 'Bl.' -- some are already fixed, but get the rest
    Address.where('address_1 LIKE ?', '%Bl.%').each do |address|
      current_address_1 = address.address_1
      new_address_1 = current_address_1.gsub('Bl.', 'Blvd.')
      puts "Replacing #{current_address_1} with #{new_address_1}"

      address.address_1 = new_address_1
      address.save
      address.geocode_with_reverse
      sleep 0.5
    end

  end
end
