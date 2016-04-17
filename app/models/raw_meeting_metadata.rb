class RawMeetingMetadata < ActiveRecord::Base
  self.table_name = "raw_meetings_metadata"
  validates :last_update, uniqueness: true
end
