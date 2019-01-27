class AddMeetingToRawMeeting < ActiveRecord::Migration[4.2]
  def change
    add_column :raw_meetings, :meeting_id, :int, index: true
  end
end
