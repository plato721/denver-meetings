FactoryBot.define do
  factory :address do
    address_1 { FFaker::AddressUS.street_address }
    notes { FFaker::DizzleIpsum.words.join.capitalize }
    city { FFaker::AddressUS.city }
    state { FFaker::AddressUS.state }
    zip { FFaker::AddressUS.zip_code }
    district { 11 }

    # approximately denver/boulder metro
    lat { rand(39.504698..40.081013) }
    lng { rand(-104.977313..-104.761446) }
  end
end
