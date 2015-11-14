require 'rails_helper'

RSpec.describe Day do
  let(:days) do
    ["Monday", "Friday", "Wednesday", "Thursday", "Sunday", "Saturday", "Tuesday"]
  end

  it "returns the day string it was created with when displayed" do
    day = Day.new(days.first)

    expect("#{day}").to eq(days.first)
  end
end