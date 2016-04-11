class MeetingsCreator
  attr_accessor :deleted, :created, :untouched
  attr_reader :raw_meetings

  def initialize(raw_meetings)
    @raw_meetings = raw_meetings
  end

  def self.update_displayable(raw_meetings)
    creator = new(raw_meetings)
    # visible meetings, no retrieved/created raw_meeting
    deleted = creator.perform_soft_delete(raw_meetings)
    created = creator.create_displayable(raw_meetings)
    creator
  end

  def perform_soft_delete(raw = self.raw_meetings)
    to_be_deleted(raw).each do |meeting|
      meeting.update_attribute(:deleted, true)
      meeting.update_attribute(:visible, false)# hide em, set them to "pending deletion"
    end
  end

  def to_be_deleted(raw = self.raw_meetings)
    bad_raw = RawMeeting.for_all_visible_meetings - raw
    displayables_to_hide = Meeting.where(raw_meeting_id: bad_raw)
    # select admin override (have some way to protect meetings
        # manually selected)
  end

  def to_be_created(raw = self.raw_meetings)
    have = Meeting.where(visible: true).pluck(:raw_meeting_id)
    need = raw.select { |raw_meeting| !have.include? raw_meeting.id }
  end

  def create_displayable(raw = self.raw_meetings)
    self.created = to_be_created(raw).map do |raw|
      sleep 1.0 #geocoder
      MeetingCreator.new(raw).create
    end
  end

end
