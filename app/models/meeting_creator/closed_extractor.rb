class MeetingCreator::ClosedExtractor
  def self.extract(raw_meeting)
    raw_meeting.codes =~ /(.*C[^A].*)|(.*C$)/
  end
end
