class SearchOptions
  attr_reader :meetings, :source

  def initialize(args={})
    args = default_args.merge(args)
    @meetings = args[:meetings]
    @source = args[:source] # who is updating the options, false if new options
  end

  def default_args
    {meetings: Meeting.all, source: false}
  end

  def as_json(options={})
    {
      "count" => self.count,
      "source" => self.source,
      "meetings" => self.meetings,
      "options" => {
        "open" => self.open?,
        "closed" => self.closed?,
        "city" => self.cities.map { |_, val| val}.flatten.compact,
        "group_name" => self.meeting_names { |_, val| val}.flatten.compact,
        "time" => self.times.map { |_, val| val}.flatten.compact,
        "day" => self.days.map { |_, val| val}.flatten.compact,
        "foci" => self.foci,
        "languages" => self.languages,
        "formats" => self.formats,
        "features" => self.features
      }
    }
  end

  def count
    self.meetings.count
  end

  def open?
    @open ||= self.meetings.exists?(closed: false)
  end

  def closed?
    @closed ||= self.meetings.exists?(closed: true)
  end

  def cities_found
    self.meetings.pluck(:city).uniq.sort
  end

  def cities
    @cities ||= begin
      any = ["--All Cities--", "any"]
      self.cities_found.prepend(any)
    end
  end

  def times_found_raw
    @times_found_raw ||= self.meetings.pluck(:time).uniq.sort
  end

  def times_found
    @times_found ||= begin
      times_found_raw.map { |t| TimeConverter.display(t) }
      .zip(times_found_raw)
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
      self.times_found.find do |display_pair|
        display_pair.last >= range_values.first &&
        display_pair.last <= range_values.last
      end
    end
  end

  def foci
    @foci ||= self.meetings.includes(:foci).pluck('foci.name').uniq.compact
  end

  def languages
    @languages ||= self.meetings.includes(:languages).pluck('languages.name').uniq.compact
  end

  def formats
    @formats ||= self.meetings.includes(:formats).pluck('formats.name').uniq.compact
  end

  def features
    @features ||= self.meetings.includes(:features).pluck('features.name').uniq.compact
  end

  def times
    @times ||= [any_time_range, now_time_range] + time_ranges + times_found
  end

  def meeting_names
    @names ||= self.meetings.uniq.order(:group_name).pluck(:group_name)
  end

  def names_select
    additional = ["--All Group Names--", "any"]
    meeting_names.zip(meeting_names).prepend(additional)
  end

  def days_found
    @days_found ||= self.meetings.pluck(:day).uniq
  end

  def days_found_sorted
    @days_found_sorted ||= Day.day_order.keep_if { |day| days_found.include? day }
  end

  def today_included?
    self.days_found_sorted.include? self.today
  end

  def today
    Day.display_today
  end

  def days
    @days ||= begin
      any = ["--Any Day--", "any"]
      today = ["Today (#{self.today})", "#{self.today}"] if self.today_included?
      days_found_sorted.zip(days_found_sorted).prepend(any, today)
    end
  end

end
