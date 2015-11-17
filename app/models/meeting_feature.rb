class MeetingFeature < ActiveRecord::Base
  belongs_to :meeting
  belongs_to :feature
end
