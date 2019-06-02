class MeetingCreator::SitterExtractor
  def self.extract(raw_meeting, _)
    raw_meeting.codes =~ /.*Sit.*/
  end
end
