class MeetingCreator::SpanishExtractor
  def self.extract(raw_meeting)
    raw_meeting.codes.include?('Spn')
  end
end
