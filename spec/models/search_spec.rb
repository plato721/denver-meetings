require 'rails_helper'

RSpec.describe Search do
  fixtures :meetings

  it "finds by name" do
    search = Search.create(group_name: "keep")
    
    expected = "Keeping It Simple"
    actual = search.results.first.group_name

    expect(actual).to eq(expected)
  end
end