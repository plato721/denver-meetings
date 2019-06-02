FactoryBot.define do
  sequence(:group_name) { |i| "Group Name #{i}" }

  factory :meeting do
    day { Day.day_order.sample }
    group_name
    address
    codes { 'n' }
    approved { true }
    time { [7, 12, 17.5].select }
    closed { false }
    raw_meeting
  end
end
