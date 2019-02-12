class MeetingCreator::Address2Extractor
  def self.extract(raw_meeting)
    matched = raw_meeting.address.match /(Unit|Ste|#)[ ]{0,}[\w-]+/
    return '' unless matched

    matched.to_s
  end
end
