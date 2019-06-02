class MeetingCreator::YoungPeopleExtractor
  def self.extract(raw_meeting, _)
    raw_meeting.codes.include?('Y')
  end
end
