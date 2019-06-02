class MeetingCreator::WomenExtractor
  def self.extract(raw_meeting, _)
    raw_meeting.codes.include?('W')
  end
end
