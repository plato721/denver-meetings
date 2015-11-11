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
      times = Meeting.joins(:raw_meeting).uniq.pluck(:time).sort
      times_am = times.select { |t| t =~ /A/ }
      times_pm = times.select { |t| t =~ /P/ }
      times_am.concat(times_pm)
    end
  end

  def times_select
    any = ["--Any Time--", "Any"]
    now = ["Right Now","Now"]
    times.zip(times).prepend(any, now)
  end

  def meeting_names
    @names ||= Meeting.uniq.pluck(:group_name)
  end

  def names_select
    additional = ["--All Group Names--", "Any"]
    meeting_names.zip(meeting_names).prepend(additional)
  end

  def days
    @days ||= begin
      ["Sunday", "Monday", "Tuesday", "Wednesday",
      "Thursday", "Friday", "Saturday", "Sunday"]
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