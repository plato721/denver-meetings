class MeetingCreator::TraditionsExtractor
  def self.extract(raw_meeting)
    raw_meeting.codes =~ /(.*[^S]T.*)|(^T.*)/
  end
end
