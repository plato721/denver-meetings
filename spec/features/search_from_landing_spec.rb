require 'rails_helper'

RSpec.feature "Search from landing" do
  fixtures :meetings

  context "as mobile user" do
    scenario "it is directed to a search form" do
      visit root_path
      click_link_or_button "meetings-button"
      expect(current_path).to eq(new_mobile_search_path)
    end

    scenario "it can view all listings" do
      visit root_path
      click_link_or_button "meetings-button"
      expect(page).to have_content("Find a Meeting")
      click_link_or_button "Search"
      expect(page).to have_content("Meetings Found")
      expect(page).to have_content("Tuesday")
    end
  end
end