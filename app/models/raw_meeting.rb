class RawMeeting < ActiveRecord::Base

  def self.add_from(raw)
    checksum = meeting_unique?(raw)
    return if !checksum
    self.create(
      {day: raw[0],
      time: raw[1], 
      group_name: raw[2], 
      address: raw[3],
      city: raw[4],
      district: raw[5],
      codes: raw[6],
      checksum: checksum})
  end

  def self.meeting_unique?(raw)
    checksum = compute_checksum(raw)
    RawMeeting.exists?(checksum: checksum) ? false : checksum
  end

  def self.compute_checksum(raw)
    Digest::SHA1.hexdigest(raw.join)
  end
end