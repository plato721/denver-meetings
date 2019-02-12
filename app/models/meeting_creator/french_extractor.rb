class MeetingCreator::FrenchExtractor
  def self.extract(raw_meeting)
    raw_meeting.codes.include?('Frn')
  end
end
