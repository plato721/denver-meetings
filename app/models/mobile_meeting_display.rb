class MobileMeetingDisplay
  attr_reader :meeting

  def initialize(meeting)
    @meeting = meeting
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

  def approved
    meeting.approved ? "True" : "False"
  end

  def day
    meeting.day.capitalize
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