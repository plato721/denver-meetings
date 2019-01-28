class RawMeeting < ActiveRecord::Base
  has_one :meeting
  validate :codes_is_a_string

  before_validation :check_codes

  def check_codes
    self.codes = "" if codes.nil?
  end

  def codes_is_a_string
    self.codes.is_a? String
  end

  def self.add_from(raw)
    self.where(
      day: raw[0],
      time: raw[1],
      group_name: raw[2],
      address: raw[3],
      city: raw[4],
      district: raw[5],
      codes: raw[6]
    ).first_or_create
  end

  def self.for_all_non_daccaa_deleted
    RawMeeting.joins(:meeting).where('meetings.deleted' => false)
  end

  def self.raw_from_yaml(file)
    YAML.load(File.read(file))
  end

  def self.from_yaml(file)
    raw_from_yaml(file).map do |data|
      add_from(data.values)
    end
  end
end
