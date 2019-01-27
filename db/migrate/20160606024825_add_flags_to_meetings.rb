class AddFlagsToMeetings < ActiveRecord::Migration[4.2]
  def change
    add_column :meetings, :flags, :integer, null: false, default: 0
  end
end
