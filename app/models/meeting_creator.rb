class MeetingCreator
  attr_reader :raw

  def initialize(raw)
    @raw = raw
  end

  def create
    Meeting.create({
      group_name: group_name,
      day: day,
      address_1: address_1,
      notes: notes,
      district: district,
      city: city,
      state: "CO",
      raw_meeting: self.raw
      })
  end

  def day
    raw.day
  end

  def time
    TimeConverter.to_dec(raw.time)
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
end