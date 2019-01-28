class ReaddNilAddress1Meetings < ActiveRecord::Migration[5.2]
  def change
    raw_meeting_addresses = RawMeeting.pluck(:address).select{ |name| name.match /\S\(/ }
    raw_meetings = RawMeeting.where(address: raw_meeting_addresses)
    meetings = Meeting.where(raw_meeting: raw_meetings)

    Rails.logger.info { "About to delete meetings: #{meetings}" }
    meetings.destroy_all

    Rails.logger.info { "About to delete raw_meetings: #{raw_meetings}" }
    raw_meetings.destroy_all
  end
end
