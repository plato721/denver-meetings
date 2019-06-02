class MeetingCreator::AslExtractor
  def self.extract(raw_meeting, _)
    raw_meeting.codes =~ /.*ASL.*/
  end
end
