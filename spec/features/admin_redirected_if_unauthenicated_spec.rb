require 'rails_helper'

RSpec.feature "Admin redirected if unauthenticated" do
  scenario "when accessing /admin" do
    visit "/admin"
  end
end