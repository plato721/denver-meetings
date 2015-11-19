class MobileMeetingDisplay
  attr_reader :meeting, :raw_distance

  def initialize(meeting, distance=nil)
    @meeting = meeting
    @raw_distance = distance
  end

  def distance
    "#{raw_distance.round(1)}"
  end

  def closed?
    self.meeting.closed == true
  end

  def raw_time
    self.meeting.time
  end

  def raw_day
    Day.day_to_int[self.meeting.day]
  end

  def group_name
    meeting.group_name
  end

  def address
    meeting.address_2.nil? ? three_line_address : four_line_address
  end

  def three_line_address
    "#{meeting.address_1}<br>#{meeting.city}, #{meeting.state}"
  end

  def four_line_address
    "#{meeting.address_1}<br>#{meeting.address_2}<br>#{meeting.city}, #{meeting.state}"
  end

  def approved?
    meeting.approved ? "True" : "False"
  end

  def day
    Day.new(meeting.day.capitalize)
  end

  def time
    TimeConverter.display(meeting.time)
  end

  def notes
    meeting.notes
  end

  def coords
    "#{meeting.lat}, #{meeting.lng}"
  end

  def phone
    meeting.phone
  end

  def map_url
    ExternalMapLink.new(meeting).url
  end
end