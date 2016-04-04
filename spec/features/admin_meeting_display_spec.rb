require 'rails_helper'

RSpec.feature "Admin meeting display" do
  fixtures :meetings

  context "as an admin" do
    let(:admin){ User.find_by(nickname: "plato721") }
    before do
      login(admin)
      allow_any_instance_of(Meeting).to receive(:address_from_coords).and_return(nil)
      allow_any_instance_of(Meeting).to receive(:custom_reverse).and_return(nil)
    end

    after(:each) do
      page.driver.submit :delete, "/logout", {}
    end

    it "displays a list of meetings" do
      visit admin_root_path
      expect(current_path).to eq(admin_meetings_path)
      expect(page).to have_content(Meeting.first.group_name)
    end

    it "can edit a meeting" do
      meeting = Meeting.first
      id = meeting.id
      group_name = meeting.group_name

      visit admin_meetings_path
      within(:css, "td#approval-display-#{id}") do
        click_link_or_button "False"
      end
      expect(current_path).to eq("/admin/meetings/#{id}/edit")
      fill_in "meeting_group_name", with: "Patterns on whiteboards"
      click_link_or_button "Update Meeting"
      expect(page).to have_content("Patterns on whiteboards")
      expect(page).to_not have_content(group_name)
    end
  end
end