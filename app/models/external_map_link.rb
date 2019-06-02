class ExternalMapLink
  attr_reader :meeting, :zoom

  def initialize(meeting, zoom=15)
    @meeting = meeting
    @zoom = zoom
  end

  def url
    "http://maps.google.com/maps?q=loc:#{self.meeting.address&.lat},#{self.meeting.address&.lng}"
  end
end
