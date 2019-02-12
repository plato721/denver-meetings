class MeetingCreator::BeginnerExtractor
  def extract(raw_meeting)
    raw_meeting.codes.include?('B') && (codes.count('B') != 2)
  end
end
