require 'rails_helper'

RSpec.feature "Search from landing" do
  context "as mobile user" do
    scenario "it is directed to a search form" do
      visit root_path
      click_link_or_button "meetings-button"
      expect(current_path).to eq(mobile_search_index_path)
    end
  end
end