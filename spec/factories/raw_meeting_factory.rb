FactoryBot.define do
  sequence :raw_meeting_address do |i|
    house_number = 3600 + i
    "#{house_number} S. Clarkson (NE of Ch)"
  end
  factory :raw_meeting do
    day { 'Sunday' }
    group_name { 'Keeping It Simple' }
    address { generate :raw_meeting_address }
    city { 'Englewood' }
    district { 11 }
    codes { '*n' }
    time { '06:30 AM' }
  end
end
