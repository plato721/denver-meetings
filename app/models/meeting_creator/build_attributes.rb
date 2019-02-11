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
      extractor = handler(attribute)
      extracted_value = extractor.extract(raw_meeting, attribute)
      attributes[attribute] = extracted_value
    end
  end

  # Go find a handler of the form:
  #   MeetingCreator:<Attribute>Extractor
  # If you can't find one, use:
  #   MeetingCreator::PassthroughExtractor
  def handler(attribute)
    base = attribute.to_s.delete('_').titleize
    base = 'MeetingCreator::' + base + 'Extractor'
    base.constantize
  rescue NameError
    MeetingCreator::PassthroughExtractor
  end
end
