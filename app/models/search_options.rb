# frozen_string_literal: true

# This class builds available options from which to choose for the front end.
# It needs an array of objects that have a meeting id. Those ids are then
# used to get a Meeting::ActiveRecord_Relation. The meetings are then
# looked at to see what filters are applicable when #as_json is called.
# The filters are given along with a meeting count.
# Usage: initalize with args[:meetings], then use to_json or as_json to
#        compute and be presented with available filters and meeting count.
class SearchOptions
  attr_reader :meetings, :source

  def initialize(args = {})
    args = default_args.merge(args)
    @meetings = cleanse_meetings(args[:meetings])
    @source = args[:source] # who is updating the options, false if new options
  end

  def cleanse_meetings(meetings)
    Meeting.where(id: meetings.map(&:id))
  end

  def default_args
    { meetings: Meeting.all, source: false }
  end

  def as_json(*)
    {
      'count' => count,
      'source' => source,
      'meetingIds' => meetings.map(&:id),
      'meetings' => meetings,
      'options' => {
        'open' => open?,
        'closed' => closed?,
        'city' => cities_json,
        'group_name' => meetings_json,
        # self.meeting_names { |_, val| val}.flatten.compact,
        'time' => times.map { |_, val| val }.flatten.compact,
        'day' => days.map { |_, val| val }.flatten.compact,
        'foci' => foci,
        'languages' => languages,
        'formats' => formats,
        'features' => features
      }
    }
  end

  def count
    meetings.count
  end

  def open?
    meetings.where(closed: [false, nil]).exists?
  end

  def closed?
    meetings.where(closed: true).exists?
  end

  def cities_found
    meetings.distinct.pluck(:city).sort
  end

  def cities_json
    ['any'] + cities_found
  end

  def cities
    any = ['City', 'any']
    cities_found.prepend(any)
  end

  def times_found_raw
    meetings.distinct.pluck(:time).sort
  end

  def times_found
    times_found_raw.map { |t| TimeConverter.display(t) }
                   .zip(times_found_raw)
  end

  def self.display_range_to_raw
    {
      'am' => [0, 9.99],
      'noon' => [10, 14.99],
      'pm' => [15, 18.99],
      'late' => [19, 23.99],
      'now' => [TimeConverter.now, TimeConverter.now + 3]
    }
  end

  def now_time_range
    ['Right Now', 'now']
  end

  def any_time_range
    ['Time', 'any']
  end

  def possible_time_ranges
    am = ['Morning (before 10a)', 'am']
    noon = ['Midday (10a - 3p)', 'noon']
    pm = ['Afternoon (3p - 7p)', 'pm']
    late = ['Evening (7p +)', 'late']
    [am, noon, pm, late]
  end

  def time_ranges
    possible_time_ranges.select do |range|
      range_values = self.class.display_range_to_raw[range.last]
      times_found.find do |display_pair|
        display_pair.last >= range_values.first &&
          display_pair.last <= range_values.last
      end
    end
  end

  def focus_methods
    [:men, :women, :gay, :young_people]
  end

  def foci
    focus_methods.map do |focus|
      focus.to_s.titleize if meetings.where(focus => true).exists?
    end.compact
  end

  def language_methods
    [:spanish, :french, :polish]
  end

  def languages
    language_methods.map do |language|
      language.to_s.titleize if meetings.where(language => true).exists?
    end.compact
  end

  def format_methods
    [:speaker, :step, :big_book, :grapevine, :traditions, :candlelight,
     :beginners]
  end

  def formats
    format_methods.map do |format|
      format.to_s.titleize if meetings.where(format => true).exists?
    end.compact
  end

  def feature_methods
    [:asl, :accessible, :non_smoking, :sitter]
  end

  def features
    feature_methods.map do |feature|
      feature.to_s.titleize if meetings.where(feature => true).exists?
    end.compact
  end

  def times
    [any_time_range, now_time_range] + time_ranges + times_found
  end

  def meeting_names
    meetings.distinct.pluck(:group_name).sort
  end

  def meetings_json
    ['any'] + meetings.distinct.pluck(:group_name).sort
  end

  def names_select
    additional = ['Group', 'any']
    meeting_names.zip(meeting_names).prepend(additional)
  end

  def days_found
    meetings.distinct.pluck(:day)
  end

  def days_found_sorted
    Day.day_order.keep_if { |day| days_found.include?(day) }
  end

  def today_included?
    days_found_sorted.include?(today)
  end

  def today
    Day.display_today
  end

  def days
    any = ['Day', 'any']
    today = ["Today (#{today})", today.to_s] if today_included?
    days_found_sorted.zip(days_found_sorted).prepend(any, today)
  end
end
