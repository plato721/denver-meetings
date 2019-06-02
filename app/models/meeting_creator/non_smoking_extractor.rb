class MeetingCreator::NonSmokingExtractor
  def self.extract(raw_meeting, _)
    raw_meeting.codes =~ /(^n.*)|.*[^pr]n.*/
  end
end
