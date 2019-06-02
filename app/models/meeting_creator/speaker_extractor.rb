class MeetingCreator::SpeakerExtractor
  def self.extract(raw_meeting, _)
    raw_meeting.codes.include?('SP')
  end
end
