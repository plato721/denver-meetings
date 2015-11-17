class MeetingLanguage < ActiveRecord::Base
  belongs_to :meeting
  belongs_to :language
end
