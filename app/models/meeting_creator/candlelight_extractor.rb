class MeetingCreator::CandlelightExtractor
  def self.extract(raw_meeting)
    raw_meeting.codes.include?('CA')
  end
end
