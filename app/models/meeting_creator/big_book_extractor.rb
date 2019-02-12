class MeetingCreator::BigBookExtractor
  def self.extract(raw_meeting)
    raw_meeting.codes.include?('BB')
  end
end
