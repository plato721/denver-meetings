class MeetingCreator::MenExtractor
  def self.extract(raw_meeting, _)
    raw_meeting.codes.include?('M')
  end
end
