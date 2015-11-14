class MobileListDisplay
  include Enumerable
  attr_reader :meetings

  def initialize(meetings)
    @meetings = meetings
  end

  def list
    self.meetings.group_by{ |meeting| meeting.day}
  end

  def each
    self.list.each do |meeting_listing|
      yield meeting_listing
    end
  end
end