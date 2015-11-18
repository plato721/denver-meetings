require 'rails_helper'

RSpec.feature "Authentication and authorization" do
  context "as an admin" do
    let(:user) { User.find_by(nickname: "plato721") }

    xscenario "when accessing /admin" do
      login(user)
      visit "/admin"
      expect(current_path).to eq("/admin/meetings")
    end
  end

end