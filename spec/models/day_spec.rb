require 'rails_helper'

RSpec.describe Day do
  let(:days) do
    ["Monday", "Friday", "Wednesday", "Thursday", "Sunday", "Saturday", "Tuesday"]
  end

  let(:sorted_days) do
    ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
  end

  it "returns the day string it was created with when displayed" do
    day = Day.new(days.first)

    expect("#{day}").to eq(days.first)
  end

  it "is sortable" do
    day_objects = days.map { |day| Day.new(day) }

    expect(day_objects.sort.map {|day| day.to_s}).to eq(sorted_days)
  end
end