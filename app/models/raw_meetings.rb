class RawMeetings < ActiveRecord::Base
  def self.add_from(raw)
    self.create({day: raw[0],
    time: raw[1], 
    group_name: raw[2], 
    address: raw[3],
    city: raw[4],
    district: raw[5],
    codes: raw[6]})
  end
end