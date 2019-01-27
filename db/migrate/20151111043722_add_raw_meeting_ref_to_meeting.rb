class AddRawMeetingRefToMeeting < ActiveRecord::Migration[4.2]
  def change
    add_reference :meetings, :raw_meeting, index: true, foreign_key: true
  end
end
