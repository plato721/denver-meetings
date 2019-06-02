class MeetingCreator::BigBookExtractor
  def self.extract(raw_meeting, _)
    raw_meeting.codes.include?('BB')
  end
end
