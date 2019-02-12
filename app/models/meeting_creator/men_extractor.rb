class MeetingCreator::MenExtractor
  def self.extract(raw_meeting)
    codes.include?('M')
  end
end
