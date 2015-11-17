class HereAndNow
  attr_reader :lat, :lng

  def initialize(params)
    @lat = params[:lat].to_f
    @lng = params[:lng].to_f
  end

  def meeting_types
    {open: "any",
    men: "show",
    women: "show",
    youth: "show",
    gay: "show",
    access: "show",
    non_smoking: "show",
    sitter: "show",
    spanish: "show",
    polish: "show",
    french: "show"}
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
      meeting_groups[distance.last] = [].concat(meetings.select do |meeting|
        meeting.raw_distance >= distance.first.first &&
        meeting.raw_distance < distance.first.last
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

  def upcoming_meetings
    criteria = (day: Day.display_today, time: "now").merge(meeting_types)
    now_meetings = Meeting.search(criteria)
    return now_meetings if now_meetings.count > 10
    now_meetings.concat(first_morning_meetings)
  end

  def first_morning_meetings
    morning_meetings = Meeting.search(day: Day.display_tomorrow, time: "am")
    .order(:time)
  end

  def search
    now_meetings = upcoming_meetings.take(20)
    now_meetings_distance = meetings_with_distance(now_meetings)
    display_meetings = create_distance_displayable(now_meetings_distance)
    display_groups = display_grouped_distance(display_meetings)
  end
end