class MeetingCreator::NotesExtractor
  def self.extract(raw_meeting)
    notes_match = raw_meeting.address.match(/\(.+\)/)
    notes = notes_match ? notes_match.to_s : ""
    notes.delete(')(')
  end
end
