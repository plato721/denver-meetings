class AddTimeToMeeting < ActiveRecord::Migration
  def change
    add_column :meetings, :time, :decimal
  end
end
