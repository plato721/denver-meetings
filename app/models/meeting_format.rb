class MeetingFormat < ActiveRecord::Base
  belongs_to :meeting
  belongs_to :format
end
