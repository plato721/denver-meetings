class MeetingCreator
  attr_reader :raw

  def initialize(raw)
    @raw = raw
  end

  def create
    meeting = Meeting.new(build_attributes)
    meeting.tap{ |m| m.save }
  end

  def build_attributes
    base_attributes.merge(format_attributes)
  end

  def base_attributes
    { group_name: group_name,
      day: day,
      address_1: address_1,
      notes: notes,
      district: district,
      city: city,
      state: "CO",
      closed: closed,
      time: time,
      raw_meeting: self.raw }
  end

  def format_attributes
    properties_models.inject({}) do |attributes, prop_set|
      attributes.merge get_property_set_for(codes, prop_set.to_a)
    end
  end

  def day
    raw.day
  end

  def time
    TimeConverter.to_dec(raw.time)
  end

  def closed
    codes =~ /(.*C[^A].*)|(.*C$)/ ? true : false
  end

  def group_name
    raw.group_name
  end

  def city
    city ||= raw.city
  end

  def notes
    notes ||= raw_notes.to_s.gsub(/[(|)]/, "")
  end

  def raw_notes
    raw_notes ||= self.raw.address.match(/\(.+\)/)
  end

  def codes
    raw.codes
  end

  def address_1
    raw_notes ? raw_notes.pre_match.to_s.strip! : raw.address
  end

  def address_2
    #logic here
  end

  def phone
    #logic here
  end

  def district
    raw.district
  end

  def properties_models
    {Focus => "foci",
    Format => "formats",
    Feature => "features",
    Language => "languages"}
  end

  def self.features_classes
    @@features_classes ||= self.new(nil).properties_models.keys
  end

  def get_property_set_for(codes, property)
    property.first.send("get_#{property.last}".to_sym, (codes))
  end

end
