class MeetingCreator::WomenExtractor
  def self.extract(raw_meeting)
    raw_meeting.codes.include?('W')
  end
end
