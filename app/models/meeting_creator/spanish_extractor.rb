class MeetingCreator::SpanishExtractor
  def self.extract(raw_meeting, _)
    raw_meeting.codes.include?('Spn')
  end
end
