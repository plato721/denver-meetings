class SearchOptions
  def initialize
  end

  def cities
    @cities ||= Meeting.uniq.pluck(:city).sort
  end

  def cities_select
    any = ["--All Cities--", "Any"]
    here = ["--Right Here--", "Here"]
    cities.prepend(here).prepend(any)
  end

  def times
    @select_times ||= begin
      times = Meeting.uniq.pluck(:time).sort
      times.map { |t| TimeConverter.display(t) }
      .zip(times)
    end
  end

  def time_ranges
    am = ["Morning (before 10a)", "am"]
    noon = ["Midday (10a - 3p)", "noon"]
    pm = ["Afternoon (3p - 7p)", "pm"]
    late = ["Evening (7p +)", "late"]
    [am, noon, pm, late]
  end

  def times_select
    any = ["--Any Time--", "Any"]
    now = ["Right Now","Now"]
    time_ranges.concat(times).prepend(any, now)
  end

  def meeting_names
    @names ||= Meeting.uniq.order(:group_name).pluck(:group_name)
  end

  def names_select
    additional = ["--All Group Names--", "Any"]
    meeting_names.zip(meeting_names).prepend(additional)
  end

  def days
    @days ||= begin
      ["Sunday", "Monday", "Tuesday", "Wednesday",
      "Thursday", "Friday", "Saturday"]
    end
  end

  def days_select
    any = ["--Any Day--", "Any"]
    days.zip(days).prepend(any)
  end

  def special
    ["Beginner", "Women", "Men", "Gay", "Youth"]
  end

  def special_select
    any = ["--No Special Focus--", "Any"]
    special.zip(special).prepend(any)
  end

  def format_select
    ["Open (Non-alcoholics Okay)", "Closed (Alcoholics Only)"]
    format.zip(format)
  end

  def format
    ["Open", "Closed"]
  end

end