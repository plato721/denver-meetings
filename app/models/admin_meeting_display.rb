class AdminMeetingDisplay
  attr_reader :meeting

  def initialize(meeting)
    @meeting = meeting
  end

  def id
    meeting.id
  end

  def group_name
    meeting.group_name
  end

  def address
    [ meeting&.address&.address_1,
      meeting&.address&.address_2,
      "#{meeting&.address&.city}, #{meeting&.address&.state}"
    ].select(&:present?).join("<br>").html_safe
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
    lat = meeting&.address&.lat ? "#{meeting&.address&.lat}" : "?"
    lng = meeting&.address&.lng ? "#{meeting&.address&.lng}" : "?"

    "#{lat}, #{lng}"
  end

  def phone
    meeting.phone
  end

  def map_url
    ExternalMapLink.new(meeting).url
  end
end
