class MeetingCreator
  attr_reader :raw

  def initialize(raw)
    @raw = raw
  end

  def city
    city ||= raw.city
  end

  def notes
    notes ||= raw_notes.to_s.gsub(/[(|)]/, "")
  end

  def raw_notes
    raw_notes ||= raw.address.match(/\(.+\)/)
  end

  def address_1
    address_1 ||= raw_notes.pre_match.to_s.strip!
  end
end