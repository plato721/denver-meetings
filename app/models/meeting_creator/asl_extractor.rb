class MeetingCreator::AslExtractor
  def self.extract(raw_meeting)
    raw_meeting.codes =~ /.*ASL.*/
  end
end
