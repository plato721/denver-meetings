class MeetingCreator::PolishExtractor
  def self.extract(raw_meeting)
    raw_meeting.codes.include?('Pol')
  end
end
