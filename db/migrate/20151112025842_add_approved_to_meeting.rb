class AddApprovedToMeeting < ActiveRecord::Migration
  def change
    add_column :meetings, :approved, :boolean, default: false
  end
end
