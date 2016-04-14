class MeetingsCreator
  attr_accessor :deleted, :created, :untouched
  attr_reader :raw_meetings

  def initialize(raw_meetings)
    @raw_meetings = raw_meetings
  end

  def self.update_displayable(raw_meetings)
    creator = new(raw_meetings)
    creator.tap { |c| c.update_displayable }
  end

  def update_displayable
    self.deleted = creator.perform_soft_delete
    self.untouched = visible_meetings # must delete first
    self.created = creator.create_displayable
  end

  def perform_soft_delete
    to_be_deleted.each do |meeting|
      # hide em, set them to "pending deletion"
      meeting.update_attribute(:deleted, true)
      meeting.update_attribute(:visible, false)
    end
  end

  def to_be_deleted
    bad_raw = RawMeeting.for_all_visible_meetings - self.raw_meetings
    displayables_to_hide = Meeting.where(raw_meeting_id: bad_raw)
    # select admin override (have some way to protect meetings
        # manually selected)
  end

  def visible_meetings
    Meeting.where(visible: true)
  end

  def to_be_created
    have = visible_meetings.pluck(:raw_meeting_id)
    need = raw_meetings.select { |raw_meeting| !have.include? raw_meeting.id }
  end

  def create_displayable
    to_be_created.map do |raw|
      sleep 1.0 #geocoder
      MeetingCreator.new(raw).create
    end
  end

end
