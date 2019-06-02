class MeetingCreator::GrapevineExtractor
  def self.extract(raw_meeting, _)
    raw_meeting.codes.include?('GV')
  end
end
