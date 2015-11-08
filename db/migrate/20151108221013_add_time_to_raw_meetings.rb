class AddTimeToRawMeetings < ActiveRecord::Migration
  def change
    add_column :raw_meetings, :time, :string
  end
end
