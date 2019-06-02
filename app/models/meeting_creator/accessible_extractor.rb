class MeetingCreator::AccessibleExtractor
  def self.extract(raw_meeting, _)
    raw_meeting.codes =~ /.*\*.*/
  end
end
