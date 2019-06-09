FactoryBot.define do
  sequence(:group_name) { |i| "Group Name #{i}" }

  factory :meeting do
    address { nil }
    day { Day.day_order.sample }
    group_name
    codes { 'n' }
    approved { true }
    time { [7, 12, 17.5].select }
    closed { false }
    raw_meeting

    after(:create) do |m|
      if m.address.blank?
        m.update_attribute(:address, FactoryBot.create(:address))
      end
    end
  end
end
