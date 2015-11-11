class AddRawMeetingRefToMeeting < ActiveRecord::Migration
  def change
    add_reference :meetings, :raw_meeting, index: true, foreign_key: true
  end
end
