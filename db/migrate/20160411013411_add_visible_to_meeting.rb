class AddVisibleToMeeting < ActiveRecord::Migration[4.2]
  def change
    add_column :meetings, :visible, :boolean, default: true
  end
end
