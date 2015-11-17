class SearchOptions
  def initialize
  end

  def cities
    @cities ||= Meeting.uniq.pluck(:city).sort
  end

  def cities_select
    any = ["--All Cities--", "any"]
    cities.prepend(any)
  end

  def times
    @select_times ||= begin
      times = Meeting.uniq.pluck(:time).sort
      times.map { |t| TimeConverter.display(t) }
      .zip(times)
    end
  end

  def self.display_range_to_raw
    {"am" => [0, 9.99],
      "noon" => [10, 14.99],
      "pm" => [15, 18.99],
      "late" => [19, 23.99],
      "now" => [TimeConverter.now, TimeConverter.now + 3]
    }
  end

  def time_ranges
    am = ["Morning (before 10a)", "am"]
    noon = ["Midday (10a - 3p)", "noon"]
    pm = ["Afternoon (3p - 7p)", "pm"]
    late = ["Evening (7p +)", "late"]
    [am, noon, pm, late]
  end

  def times_select
    any = ["--Any Time--", "any"]
    now = ["Right Now","now"]
    time_ranges.concat(times).prepend(any, now)
  end

  def meeting_names
    @names ||= Meeting.uniq.order(:group_name).pluck(:group_name)
  end

  def names_select
    additional = ["--All Group Names--", "any"]
    meeting_names.zip(meeting_names).prepend(additional)
  end

  def days
    @days ||= begin
      ["Sunday", "Monday", "Tuesday", "Wednesday",
      "Thursday", "Friday", "Saturday"]
    end
  end

  def days_select
    any = ["--Any Day--", "any"]
    today = ["Today (#{Day.display_today})", "#{Day.display_today}"]
    days.zip(days).prepend(any, today)
  end

  def format_select
    ["Open (Non-alcoholics Okay)", "Closed (Alcoholics Only)"]
    format.zip(format)
  end

  def format
    ["Open", "Closed"]
  end

end