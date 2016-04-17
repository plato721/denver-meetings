class DistanceMeetings
  include Enumerable
  attr_reader :meeting_tuples

  def initialize(meetings_with_distance)
    @meeting_tuples = meetings_with_distance
  end

  def distance_intervals
    {[0.0, 1.0] => "Within 1 mile",
     [1.0, 3.0] => "Within 3 miles",
     [3.0, 5.0] => "Within 5 miles",
     [5.0, 10.0] => "Within 10 miles",
     [10.0, 20.0] => "Within 20 miles",
     [20.0, 50.0] => "Within 50 miles",
     [50.0, 100000] => "Over 50 miles"}
  end

  def display_grouped_distance(meetings)
    distance_intervals.each_with_object({}) do |distance, meeting_groups|
      meeting_groups[distance.last] = [].concat(meetings.select do |meeting|
        meeting.raw_distance >= distance.first.first &&
        meeting.raw_distance < distance.first.last
      end)
    end
  end

  def create_distance_displayable(meeting_tuples)
    meeting_tuples.map do |meeting, distance|
      MobileMeetingDisplay.new(meeting, distance)
    end
  end

  def list
    display_meetings = create_distance_displayable(meeting_tuples)
    display_groups = display_grouped_distance(display_meetings)
  end

  def each
    list.each do |distance_group|
      yield distance_group
    end
  end
end
