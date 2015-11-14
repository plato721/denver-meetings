class MobileListDisplay
  include Enumerable
  attr_accessor :meetings

  def initialize(meetings)
    @meetings = meetings.map { |m| MobileMeetingDisplay.new(m) }
    sort_by_time
  end

  def sort_by_time
    self.meetings = self.meetings.sort_by { |meeting| meeting.time }
  end

  def list
    self.meetings.group_by{ |meeting| meeting.day}
    .sort_by{ |meeting_group| meeting_group.first }
  end

  def each
    self.list.each do |meeting_listing|
      yield meeting_listing
    end
  end
end