class RemoveClosedFromMeeting < ActiveRecord::Migration[4.2]
  def change
    remove_column :meetings, :closed
  end
end
