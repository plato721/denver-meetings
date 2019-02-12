# Use to create a Meeting from a RawMeeting
# - Initialize with a RawMeeting
# - Call `.create` on the returned object to create the Meeting
class MeetingCreator
  attr_reader :raw

  # raw is a RawMeeting
  def initialize(raw)
    @raw = raw
  end

  def create
    meeting = Meeting.new(build_attributes)
    meeting.tap{ |m| m.save }
  end

  def build_attributes
    MeetingCreator::BuildAttributes.build_from(raw)
    # base_attributes.merge(format_attributes)
  end

  # def base_attributes
  #   {
  #     # group_name: group_name,
  #     day: day,
  #     address_1: address_1,
  #     notes: notes,
  #     district: district,
  #     city: city,
  #     state: "CO",
  #     closed: closed,
  #     time: time,
  #     raw_meeting: self.raw
  #   }
  # end

  # def format_attributes
  #   properties_models.inject({}) do |attributes, prop_set|
  #     attributes.merge get_property_set_for(codes, prop_set.to_a)
  #   end
  # end

  # def day
  #   raw.day
  # end

  # def time
  #   TimeConverter.to_dec(raw.time)
  # end

  # def closed
  #   codes =~ /(.*C[^A].*)|(.*C$)/ ? true : false
  # end

  # def group_name
  #   raw.group_name
  # end

  # def city
  #   city ||= raw.city
  # end

  # def notes
  #   notes ||= raw_notes.gsub(/[(|)]/, "")
  # end

  # def raw_notes
  #   raw_notes ||= begin
  #     notes_match = self.raw.address.match(/\(.+\)/)
  #     notes_match ? notes_match.to_s : ""
  #   end
  # end

  # def codes
  #   raw.codes
  # end

  # def address_1
  #   raw.address.gsub(raw_notes, "")
  #              .gsub(raw_phone, "")
  #              .gsub(raw_unit, "")
  #              .strip
  # end

  def address_2
    remove_leading_comma(raw_unit)
  end

  def raw_unit
    unit_match = raw.address.match(/(, )?(unit).{0,1}\d+/i)
    unit_match ? unit_match[0] : ""
  end

  def raw_phone
    phone_match = raw.address.match(/(, )?\d{3}(-\d{3})?-\d{4}/)
    phone_match ? phone_match[0] : ""
  end

  def remove_leading_comma(raw_phone)
    has_leading_comma = raw_phone.match(/^,( )?/)
    has_leading_comma ? has_leading_comma.post_match : raw_phone
  end

  def phone
    remove_leading_comma(raw_phone)
  end

  # def district
  #   raw.district
  # end

  # def properties_models
  #   {
  #     MeetingCreator::Focus => "foci",
  #     MeetingCreator::Format => "formats",
  #     MeetingCreator::Feature => "features",
  #     MeetingCreator::Language => "languages"
  #   }
  # end

  # def self.features_classes
  #   @@features_classes ||= self.new(nil).properties_models.keys
  # end

  # def get_property_set_for(codes, property)
  #   property.first.send("get_#{property.last}".to_sym, (codes))
  # end
end
