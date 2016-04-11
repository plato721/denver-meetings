class RawMeeting < ActiveRecord::Base
  has_one :meeting
  belongs_to :meeting

  def self.add_from(raw)
    checksum = compute_checksum(raw)
    self.where(checksum: checksum)
        .first_or_create(
          {day: raw[0],
          time: raw[1],
          group_name: raw[2],
          address: raw[3],
          city: raw[4],
          district: raw[5],
          codes: raw[6]})
  end

  def self.for_all_visible_meetings
    ids = Meeting.joins(:raw_meeting).where(visible: true).pluck(:raw_meeting_id)
    self.where(id: ids)
  end

  def self.from_yaml(file)
    hash = YAML.load(File.read(file))
    hash.map do |data|
      add_from(data.values)
    end
  end

  def self.meeting_unique?(raw)
    checksum = compute_checksum(raw)
    RawMeeting.exists?(checksum: checksum) ? false : checksum
  end

  def self.compute_checksum(raw)
    Digest::SHA1.hexdigest(raw.join)
  end
end