class AddFlagsToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :flags, :integer, null: false, default: 0
  end
end
