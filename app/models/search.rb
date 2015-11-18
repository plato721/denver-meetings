class Search < ActiveRecord::Base
  def results
    self.here | self.here_and_now ? distance_results : weekday_results
  end

  def distance_results
    return HereAndNow.new(self.to_h).search if self.here_and_now
    distance_with(raw_meetings)
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
