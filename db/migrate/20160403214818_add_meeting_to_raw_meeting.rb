class AddMeetingToRawMeeting < ActiveRecord::Migration
  def change
    add_column :raw_meetings, :meeting_id, :int, index: true
  end
end
