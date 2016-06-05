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

  def meetings_with_distance(meetings)
    meetings.map do |meeting|
      [meeting, Proximal.new(meeting).distance_from([self.lat, self.lng])]
    end
  end

  def upcoming_meetings
    criteria = {day: Day.display_today, time: "now"}.merge(meeting_types)
    now_meetings = Meeting.search(criteria).geocoded
    return now_meetings if (now_meetings.count > 10 || TimeConverter.now < 19)
    now_meetings.concat(first_morning_meetings)
  end

  def first_morning_meetings
    criteria = {day: Day.display_tomorrow, time: "am"}.merge(meeting_types)
    morning_meetings = Meeting.search(criteria).geocoded
    .order(:time)
  end

  def search
    now_meetings = upcoming_meetings.take(20)
    now_meetings_distance = meetings_with_distance(now_meetings)
    DistanceMeetings.new(now_meetings_distance)
  end
end