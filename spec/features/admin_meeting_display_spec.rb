require 'rails_helper'

RSpec.feature "Admin meeting display" do
  fixtures :meetings

  context "as an admin" do
    let(:admin){ User.find_by(nickname: "plato721") }
    before do
      login(admin)
    end

    it "displays a list of meetings" do
      visit admin_root_path
      expect(current_path).to eq(admin_meetings_path)
      expect(page).to have_content(Meeting.first.group_name)
    end

    it "can edit a meeting" do
      visit admin_meetings_path
      within(:css, "td#approval-display-#{Meeting.first.id}") do
        click_link_or_button "False"
      end
      expect(current_path).to eq("/admin/meetings/#{Meeting.first.id}/edit")
      
    end
  end
end