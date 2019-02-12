class MeetingCreator::Address2Extractor
  def self.extract(raw_meeting)
    address = remove_notes(raw_meeting.address)
    matched = address.match /(Unit|Ste|#)[\.]?[ ]{0,}[\w-]+/
    return '' unless matched

    matched.to_s
  end

  def self.remove_notes(address)
    matcher = MeetingCreator::NotesExtractor.notes_matcher
    matched = address.match(matcher)
    return address unless matched

    address.delete(matched.to_s)
  end
end
