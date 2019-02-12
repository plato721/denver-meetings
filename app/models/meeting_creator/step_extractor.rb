class MeetingCreator::StepExtractor
  def self.extract(raw_meeting)
    raw_meeting.codes.include?('ST')
  end
end
