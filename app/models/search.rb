class Search < ActiveRecord::Base
  before_create :scrub_text

  def results
    return distance_results if distance_search?
    weekday_results
  end

  def distance_search?
    self.is_location_search || self.here_and_now
  end

  def scrub_text
    self.free = "" if self.free.blank?
  end

  def denver_center
    [39.742043, -104.991531]
  end

  def set_distance_defaults
    if( !self.lat || !self.lng )
      self.lat = denver_center.first
      self.lng = denver_center.last
      self.errors.add :free,
        "Sorry, unable to find location #{free}. Using Denver center."
    end
    self.free = ""
  end

  def distance_results
    set_distance_defaults
    return HereAndNow.new(self.to_h).search if self.here_and_now

    distance_with(raw_meetings.geocoded)
  end

  def weekday_results
    WeekdayMeetings.new(raw_meetings)
  end

  def distance_with(meetings)
    distance_finder = HereAndNow.new(self.to_h)
    meeting_tuples = distance_finder.meetings_with_distance(meetings)
    DistanceMeetings.new(meeting_tuples, self.within_miles)
  end

  def raw_meetings
    Meeting.search(self.to_h)
  end

  def to_h
    Search.column_names.map(&:to_sym).map do |column|
      [column, self.send(column)]
    end.to_h
  end
end
