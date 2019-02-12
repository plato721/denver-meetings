class MeetingCreator::NonSmokingExtractor
  def self.extract(raw_meeting)
    raw_meeting.codes =~ /(^n.*)|.*[^pr]n.*/
  end
end
