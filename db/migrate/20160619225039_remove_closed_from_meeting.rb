class RemoveClosedFromMeeting < ActiveRecord::Migration
  def change
    remove_column :meetings, :closed
  end
end
