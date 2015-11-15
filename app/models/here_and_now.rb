class HereAndNow
  attr_reader :lat, :lng

  def initialize(params)
    @lat = params[:lat].to_f
    @lng = params[:lng].to_f
  end

  def today_string
    Day.int_to_day[TimeConverter.now_raw.wday]
  end

  def distance_intervals
    {[0.0, 1.0] => "Within 1 mile",
     [1.0, 3.0] => "Within 3 miles",
     [3.0, 5.0] => "Within 5 miles",
     [5.0, 10.0] => "Within 10 miles",
     [10.0, 20.0] => "Within 20 miles",
     [20.0, 50.0] => "Within 50 miles"}
  end

  def display_grouped_distance(meetings)
    distance_intervals.each_with_object({}) do |distance, meeting_groups|
      meeting_groups[distance.last] = []
      meeting_groups[distance.last].concat(meetings.select do |meeting|
        meeting.distance > distance.first.first &&
        meeting.distance < distance.first.last
      end)
    end
  end

  def meetings_with_distance(meetings)
    meetings.map do |meeting|
      [meeting, Proximal.new(meeting).distance_from([self.lat, self.lng])]
    end
  end

  def create_distance_displayable(meeting_tuples)
    meeting_tuples.map do |meeting, distance|
      MobileMeetingDisplay.new(meeting, distance)
    end
  end

  def search
    now_meetings = Meeting.search(day: today_string, time: "now")
    now_meetings_distance = meetings_with_distance(now_meetings)
    display_meetings = create_distance_displayable(now_meetings_distance)
    display_groups = display_grouped_distance(display_meetings)
  end
end