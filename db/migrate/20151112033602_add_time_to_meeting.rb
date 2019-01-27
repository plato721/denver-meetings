class AddTimeToMeeting < ActiveRecord::Migration[4.2]
  def change
    add_column :meetings, :time, :decimal
  end
end
