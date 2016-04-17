class AddDeletedToMeeting < ActiveRecord::Migration
  def change
    add_column :meetings, :deleted, :boolean, default: false
  end
end
