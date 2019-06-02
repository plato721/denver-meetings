class MeetingCreator::ClosedExtractor
  def self.extract(raw_meeting, _)
    raw_meeting.codes =~ /(.*C[^A].*)|(.*C$)/
  end
end
