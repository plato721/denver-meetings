class Search < ActiveRecord::Base
  before_create :scrub_text

  def results
    return distance_results if distance_search?
    weekday_results
  end

  def distance_search?
    self.here || self.here_and_now
  end

  def scrub_text
    [:city_text, :group_text].each do |field|
        if self.send(field) =~ /^\(.*\)$/ || self.send(field).empty?
          self.update_attributes(field => "any")
        end
    end
  end

  def distance_results
    return HereAndNow.new(self.to_h).search if self.here_and_now
    distance_with(raw_meetings.geocoded)
  end

  def weekday_results
    WeekdayMeetings.new(raw_meetings)
  end

  def distance_with(meetings)
    distance_finder = HereAndNow.new(self.to_h)
    meeting_tuples = distance_finder.meetings_with_distance(meetings)
    DistanceMeetings.new(meeting_tuples)
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
