class MeetingFocus < ActiveRecord::Base
  belongs_to :meeting
  belongs_to :focus
end