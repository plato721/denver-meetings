class MeetingCreator::SpeakerExtractor
  def self.extract(raw_meeting)
    raw_meeting.codes.include?('SP')
  end
end
