class MeetingCreator::AccessibleExtractor
  def self.extract(raw_meeting)
    raw_meeting.codes =~ /.*\*.*/
  end
end
