class AddApprovedToMeeting < ActiveRecord::Migration[4.2]
  def change
    add_column :meetings, :approved, :boolean, default: false
  end
end
