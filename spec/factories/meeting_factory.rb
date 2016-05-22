FactoryGirl.define do
  sequence(:group_name){ |i| "Group Name #{i}" }

  factory :meeting do
    day { ["Sunday", "Monday", "Tuesday", "Wednesday",
      "Thursday", "Friday", "Saturday"].sample }
    group_name
    address_1 { FFaker::AddressUS.street_address }
    notes { FFaker::DizzleIpsum.words.join.capitalize }
    city { FFaker::AddressUS.city }
    state { FFaker::AddressUS.state }
    zip { FFaker::AddressUS.zip_code }
    district 11
    codes "n"
    # approximately denver/boulder metro
    lat { rand(39.504698..40.081013) }
    lng { rand(-104.761446..-104.977313) }
    approved true
    time { [7, 12, 17.5].select }
    closed false
    raw_meeting
  end
end