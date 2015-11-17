class AddClosedToMeeting < ActiveRecord::Migration
  def change
    add_column :meetings, :closed, :boolean, default: false
  end
end
