class MeetingCreator::GayExtractor
  def self.extract(raw_meeting)
    raw_meeting.codes =~ /(G[^V]|.*G$)/
  end
end
