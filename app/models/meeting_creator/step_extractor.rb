class MeetingCreator::StepExtractor
  def self.extract(raw_meeting, _)
    raw_meeting.codes.include?('ST')
  end
end
