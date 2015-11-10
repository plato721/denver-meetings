require 'rails_helper'

RSpec.feature "Admin redirected if unauthenticated" do
  scenario "when accessing /admin" do
    visit "/admin"
    expect(current_path).to eq("http://github")
  end
end