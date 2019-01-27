class AddClosedToMeeting < ActiveRecord::Migration[4.2]
  def change
    add_column :meetings, :closed, :boolean, default: false
  end
end
