class AddTimeToRawMeetings < ActiveRecord::Migration[4.2]
  def change
    add_column :raw_meetings, :time, :string
  end
end
