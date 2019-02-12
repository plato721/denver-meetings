class MeetingCreator::GrapevineExtractor
  def self.extract(raw_meeting)
    raw_meeting.codes.include?('GV')
  end
end
