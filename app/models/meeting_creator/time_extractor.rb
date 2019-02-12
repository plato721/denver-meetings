class MeetingCreator::TimeExtractor
  def self.extract(raw_meeting)
    TimeConverter.to_dec(raw_meeting.time)
  end
end
