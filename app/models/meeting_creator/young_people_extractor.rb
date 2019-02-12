class MeetingCreator::YoungPeopleExtractor
  def self.extract(raw_meeting)
    raw_meeting.codes.include?('Y')
  end
end
