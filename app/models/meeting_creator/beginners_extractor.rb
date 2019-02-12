class MeetingCreator::BeginnersExtractor
  def self.extract(raw_meeting)
    codes = raw_meeting.codes
    codes.include?('B') && (codes.count('B') != 2)
  end
end
