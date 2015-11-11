class MeetingCreator
  attr_reader :raw

  def initialize(raw)
    @raw = raw
  end

  def create
    Meeting.create({
      group_name: group_name,
      address_1: address_1,
      city: city,
      state: "CO"
      })
  end

  def day
    raw.day
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

  def address_1
    address_1 ||= raw_notes.pre_match.to_s.strip!
  end
end