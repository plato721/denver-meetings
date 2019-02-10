class SearchOptions
  attr_reader :meetings, :source

  def initialize(args={})
    args = default_args.merge(args)
    @meetings = cleanse_meetings(args[:meetings])
    @source = args[:source] # who is updating the options, false if new options
  end

  def cleanse_meetings(meetings)
    Meeting.where(id: meetings.map(&:id))
  end

  def default_args
    {meetings: Meeting.all, source: false}
  end

  def as_json(options={})
    {
      "count" => self.count,
      "source" => self.source,
      "meetingIds" => self.meetings.map(&:id),
      "meetings" => self.meetings,
      "options" => {
        "open" => self.open?,
        "closed" => self.closed?,
        "city" => self.cities_json,
        "group_name" => self.meetings_json,
        # self.meeting_names { |_, val| val}.flatten.compact,
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
    @open ||= self.meetings.where(closed: [false, nil]).exists?
  end

  def closed?
    @closed ||= self.meetings.where(closed: true).exists?
  end

  def cities_found
    @cities_found ||= begin
      self.meetings.pluck(:city).uniq.sort
    end
  end

  def cities_json
    ["any"] + cities_found
  end

  def cities
    @cities ||= begin
      any = ["City", "any"]
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
    any = ["Time", "any"]
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

  def focus_methods
    [:men, :women, :gay, :young_people]
  end

  def foci
    focus_methods.select do |focus|
      self.meetings.where(focus => true).exists?
    end.map { |f| f.to_s.titleize }
  end

  def language_methods
    [:spanish, :french, :polish]
  end

  def languages
    language_methods.select do |lang|
      self.meetings.where(lang => true).exists?
    end.map { |f| f.to_s.titleize }
  end

  def format_methods
    [:speaker, :step, :big_book, :grapevine,
      :traditions, :candlelight, :beginners]
  end

  def formats
    format_methods.select do |format|
        self.meetings.where(format => true).exists?
    end.map { |f| f.to_s.titleize }
  end

  def feature_methods
    [:asl, :accessible, :non_smoking, :sitter]
  end

  def features
    feature_methods.select do |feature|
      self.meetings.where(feature => true).exists?
    end.map { |f| f.to_s.titleize }
  end

  def times
    @times ||= [any_time_range, now_time_range] + time_ranges + times_found
  end

  def meeting_names
    @names ||= self.meetings.pluck(:group_name).uniq.sort
  end

  def meetings_json
    @meetings_json ||= begin
      ["any"] + self.meetings.pluck(:group_name).uniq.sort
    end
  end

  def names_select
    additional = ["Group", "any"]
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
      any = ["Day", "any"]
      today = ["Today (#{self.today})", "#{self.today}"] if self.today_included?
      days_found_sorted.zip(days_found_sorted).prepend(any, today)
    end
  end

end
