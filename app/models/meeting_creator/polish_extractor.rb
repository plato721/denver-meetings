class MeetingCreator::PolishExtractor
  def self.extract(raw_meeting, _)
    raw_meeting.codes.include?('Pol')
  end
end
