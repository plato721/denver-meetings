class AddVisibleToMeeting < ActiveRecord::Migration
  def change
    add_column :meetings, :visible, :boolean, default: true
  end
end
