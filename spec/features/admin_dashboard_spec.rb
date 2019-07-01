require 'rails_helper'

feature 'Admin Dashboard' do
  context "as an admin" do
    before :each do
      user = create(:user, role: "admin")
      login(user) 
    end

    it 'links to manage meetings' do
      visit admin_dashboard_path
      click_on "Manage Meetings"
      expect(current_path).to eq(admin_meetings_path)
    end

    it 'links to manage users' do
      visit admin_dashboard_path
      click_on "Manage Users"
      expect(current_path).to eq(admin_users_path)
    end
  end
end
