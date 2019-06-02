class MeetingCreator::GayExtractor
  def self.extract(raw_meeting, _)
    raw_meeting.codes =~ /(G[^V]|.*G$)/
  end
end
