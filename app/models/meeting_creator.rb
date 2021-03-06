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
    Meeting.create(build_attributes)
  end

  def build_attributes
    MeetingCreator::BuildAttributes.build_from(raw)
  end
end
