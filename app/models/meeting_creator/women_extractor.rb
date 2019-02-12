class MeetingCreator::Women
  def self.extract(raw_meeting)
    raw_meeting.codes.include?('W')
  end
end
