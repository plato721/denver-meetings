class MeetingsCreator
  attr_accessor :deleted, :created, :untouched
  attr_reader :raw_meetings, :throttle

  def initialize(raw_meetings, throttle=1.0)
    @raw_meetings = raw_meetings
    @throttle = throttle #geocode delay
  end

  def self.update_displayable(raw_meetings)
    creator = new(raw_meetings)
    creator.tap { |c| c.run_updates }
  end

  def run_updates
    self.deleted = perform_soft_delete
    self.untouched = non_daccaa_deleted.to_a # must delete first
    self.created = create_displayable
    log_results
  end

  def log_results
    log_message.each { |msg| Rails.logger.info msg }
  end

  def log_message
    ["MeetingsCreator was initialized with #{self.raw_meetings.count} raw meetings.",
      "#{self.created.count} meetings were created.",
      "#{self.deleted.count} meetings were deleted.",
      "#{self.untouched.count} meetings were already present and were left untouched."]
  end

  def perform_soft_delete
    to_be_deleted.each do |meeting|
      # hide em, set them to "pending deletion"
      meeting.update_attribute(:deleted, true)
      meeting.update_attribute(:visible, false)
    end
  end

  def to_be_deleted
    bad_raw = RawMeeting.for_all_non_daccaa_deleted - self.raw_meetings
    displayables_to_hide = Meeting.where(raw_meeting_id: bad_raw)
    # select admin override (have some way to protect meetings
        # manually selected)
  end

  def non_daccaa_deleted
    Meeting.where(deleted: false)
  end

  def to_be_created
    have = non_daccaa_deleted.pluck(:raw_meeting_id)
    need = raw_meetings.select do |raw_meeting|
      !( have.include?(raw_meeting.id) )
    end
  end

  def create_displayable
    to_be_created.map do |raw|
      sleep self.throttle
      MeetingCreator.new(raw).create
    end
  end

end
