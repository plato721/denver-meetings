class MeetingCreator::NotesExtractor
  def self.extract(raw_meeting, _)
    notes_match = raw_meeting.address.match(notes_matcher)
    notes = notes_match ? notes_match.to_s : ""
    notes.delete(')(')
  end

  def self.notes_matcher
    /\(.+\)/
  end
end
