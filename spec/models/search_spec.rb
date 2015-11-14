require 'rails_helper'

RSpec.describe Search do
  fixtures :meetings

  before(:each) do
    @search_params = {
      city: "Any",
      group_name: "Any",
      day: "Any",
      time: "Any"
    }
  end

  it "finds by name" do
    search = Search.create(@search_params.merge(group_name: "keep"))

    expected = "Keeping It Simple"
    actual = search.results.first.group_name

    expect(actual).to eq(expected)
  end
end