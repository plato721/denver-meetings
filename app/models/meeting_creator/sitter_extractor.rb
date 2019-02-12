class MeetingCreator::SitterExtractor
  def self.extract(raw_meeting)
    raw_meeting.codes =~ /.*Sit.*/
  end
end
