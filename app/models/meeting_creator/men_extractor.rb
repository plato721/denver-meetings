class MeetingCreator::MenExtractor
  def self.extract(raw_meeting)
    raw_meeting.codes.include?('M')
  end
end
