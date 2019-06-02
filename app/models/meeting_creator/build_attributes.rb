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

  def object_attributes
    [
      :address,
      :raw_meeting,
      :group_name,
      :day,
      :closed,
      :time,
      :phone,

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

  # Loop through the object_attributes. Find a handler for each, call that
  # handler, and build up a hash with the attribute and the extracted value.
  def build
    object_attributes.each_with_object({}) do |attribute, attributes|
      handler = determine_handler(attribute)
      attributes[attribute] = handler.extract(raw_meeting, attribute)
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
    base = attribute.to_s.titleize.delete(' ')
    base = 'MeetingCreator::' + base + 'Extractor'
    base.constantize
  rescue NameError
    passthru_handler
  end
end
