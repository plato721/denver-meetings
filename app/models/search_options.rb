class SearchOptions
  def initialize
  end

  def cities
    @cities ||= Meeting.uniq.pluck(:city)
  end

  def times
    @select_times ||= begin
      times = Meeting.joins(:raw_meeting).uniq.pluck(:time).sort
      times_am = times.select { |t| t =~ /A/ }
      times_pm = times.select { |t| t =~ /P/ }
      times_am.concat(times_pm)
    end
  end

  def meeting_names
    @names ||= Meeting.uniq.pluck(:group_name)
  end

  def days
    @days ||= begin
      ["Sunday", "Monday", "Tuesday", "Wednesday",
      "Thursday", "Friday", "Saturday", "Sunday"]
    end
  end

  def special
    ["Beginner", "Women", "Men", "Gay", "Youth"]
  end

  def format
  end

end