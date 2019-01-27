class AddDeletedToMeeting < ActiveRecord::Migration[4.2]
  def change
    add_column :meetings, :deleted, :boolean, default: false
  end
end
