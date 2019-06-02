class MeetingCreator::FrenchExtractor
  def self.extract(raw_meeting, _)
    raw_meeting.codes.include?('Frn')
  end
end
