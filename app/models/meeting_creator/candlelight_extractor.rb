class MeetingCreator::CandlelightExtractor
  def self.extract(raw_meeting, _)
    raw_meeting.codes.include?('CA')
  end
end
