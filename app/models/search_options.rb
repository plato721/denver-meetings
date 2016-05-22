class SearchOptions
  attr_reader :meetings

  def initialize(meetings=nil)
    @meetings = meetings
    @meetings ||= Meeting.all
  end

  def cities
    @cities ||= self.meetings.pluck(:city).uniq.sort
  end

  def cities_select
    any = ["--All Cities--", "any"]
    cities.prepend(any)
  end

  def times
    @select_times ||= begin
      times = self.meetings.pluck(:time).uniq.sort
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

  def now_time_range
    now = ["Right Now","now"]
  end

  def any_time_range
    any = ["--Any Time--", "any"]
  end

  def possible_time_ranges
    am = ["Morning (before 10a)", "am"]
    noon = ["Midday (10a - 3p)", "noon"]
    pm = ["Afternoon (3p - 7p)", "pm"]
    late = ["Evening (7p +)", "late"]
    [am, noon, pm, late]
  end

  def time_ranges
    possible_time_ranges.select do |range|
      range_values = self.class.display_range_to_raw[range.last]
      self.times.find do |display_pair|
        display_pair.last >= range_values.first &&
        display_pair.last <= range_values.last
      end
    end
  end

  def focus_select
    self.meetings.includes(:foci).pluck('foci.name').uniq.compact
  end

  def language_select
    self.meetings.includes(:languages).pluck('languages.name').uniq.compact
  end

  def times_select
    [any_time_range, now_time_range] + time_ranges
  end

  def meeting_names
    @names ||= Meeting.uniq.order(:group_name).pluck(:group_name)
  end

  def names_select
    additional = ["--All Group Names--", "any"]
    meeting_names.zip(meeting_names).prepend(additional)
  end

  def days
    @days ||= self.meetings.pluck(:day).uniq
  end

  def days_select
    any = ["--Any Day--", "any"]
    today = ["Today (#{Day.display_today})", "#{Day.display_today}"]
    days.zip(days).prepend(any, today)
  end

end
