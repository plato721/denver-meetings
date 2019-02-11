# Use with ::build_from and pass a RawMeeting
# Takes a raw meeting, and returns attributes with which to create a Meeting
# For every Meeting attribute, selects the proper attribute builder,
# defaulting to simply passing through the raw attribute.
class MeetingCreator::BuildAttributes
  attr_reader :raw_meeting

  def self.build_from(raw_meeting)
    ba = new(raw_meeting)
    ba.build
  end

  # Note, zip code, lat, and lng will come from geocoding done in Meeting
  def self.meeting_attributes
    [
      :raw_meeting,
      :group_name,
      :day,
      :closed,
      :time,
      :address_1,
      :address_2,
      :notes,
      :district,
      :city,
      :state,
      # 'Features'
      :asl,
      :accessible,
      :non_smoking,
      :sitter,
      # 'Format'
      :speaker,
      :step,
      :big_book,
      :grapevine,
      :traditions,
      :candlelight,
      :beginners,
      # 'Language'
      :spanish,
      :french,
      :polish,
      # 'Focus'
      :men,
      :women,
      :gay,
      :young_people
    ]
  end

  def initialize(raw_meeting)
    @raw_meeting = raw_meeting
  end

  # Loop through the meeting_attributes. Find a handler for each, call that
  # handler, and build up a hash with the attribute and the extracted value.
  def build
    self.class.meeting_attributes
        .each_with_object({}) do |attribute, attributes|
      handler = determine_handler(attribute)
      extracted_value = extract_value(handler, attribute)
      attributes[attribute] = extracted_value
    end
  end

  def extract_value(handler, attribute)
    if handler == passthru_handler
      # The passthrough handler has to know which attribute to pass through
      # from the raw_meeting.
      handler.extract(raw_meeting, attribute)
    else
      handler.extract(raw_meeting)
    end
  end

  def passthru_handler
    MeetingCreator::PassthroughExtractor
  end

  # Go find a handler of the form:
  #   MeetingCreator:<Attribute>Extractor
  # If you can't find one, use:
  #   MeetingCreator::PassthroughExtractor
  def determine_handler(attribute)
    base = attribute.to_s.delete('_').titleize
    base = 'MeetingCreator::' + base + 'Extractor'
    base.constantize
  rescue NameError
    passthru_handler
  end
end
