class MeetingCreator::PassthroughExtractor
  def self.extract(raw_meeting, attribute)
    raw_meeting.send(attribute)
  end
end
