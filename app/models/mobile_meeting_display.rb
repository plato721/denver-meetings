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
    self.meeting.closed?
  end

  def raw_time
    self.meeting.time
  end

  def raw_day
    Day.day_to_int[self.meeting.day]
  end

  def language_attributes
    [:spanish, :french, :polish]
  end

  def format_attributes
    [:speaker, :step, :big_book, :grapevine, :traditions, :candlelight,
     :beginners]
  end

  def foci_attributes
    [:men, :women, :gay, :young_people]
  end

  def features_attributes
    [:asl, :accessible, :non_smoking, :sitter]
  end

  # takes :formats, :languages, etc., gets all true flags for that group, then
  # titleizes and joins by comma for front-end presentation
  def titleized_attributes_for(group)
    send(group).map do |attribute|
      attribute.to_s.titleize if meeting.send(attribute)
    end.compact.join(", ")
  end

  def format
    titleized_attributes_for(:format_attributes)
  end

  def language
    titleized_attributes_for(:language_attributes)
  end

  def features
    titleized_attributes_for(:features_attributes)
  end

  def foci
    titleized_attributes_for(:foci_attributes)
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