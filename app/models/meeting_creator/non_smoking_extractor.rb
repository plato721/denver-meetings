class Meeting::Creator::NonSmokingExtractor
  def self.extract(raw_meeting)
    raw_meeting.codes =~ /(^n.*)|.*[^pr]n.*/
  end
end
