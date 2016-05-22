require 'rails_helper'

RSpec.describe SearchOptions do
  fixtures :foci, :languages

  before :each do
    Meeting.destroy_all
    allow_any_instance_of(Meeting).to receive(:geocode).and_return(nil)
  end

  it "is narrowed when initialized with meetings" do
    FactoryGirl.create_list :meeting, 5

    meetings = Meeting.where(id: Meeting.first.id)
    options_narrowed = SearchOptions.new(meetings)

    expect(options_narrowed.meetings.count < Meeting.count).to be_truthy
  end

  it "dynamically returns meeting day options" do
    days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    days.each { |d| FactoryGirl.create :meeting, day: d }

    options_all = SearchOptions.new
    options_narrowed = SearchOptions.new(Meeting.where(day: ["Tuesday", "Thursday"]))

    expect(options_all.days).to eq(days)
    expect(options_narrowed.days).to eq(["Tuesday", "Thursday"])
  end

  it "dynamically returns clock time options" do
    times = [*18..24]
    times.each { |t| FactoryGirl.create :meeting, time: t }

    fewer_times = [19, 20]
    options_all = SearchOptions.new
    options_fewer = SearchOptions.new(Meeting.where(time: fewer_times))

    expect(options_all.times.length).to eq(times.length)
    expect(options_fewer.times.length).to eq(fewer_times.length)
    times.each do |t|
      expect(options_all.times.find do |display_pair|
        display_pair.last.to_i == t
      end).to be_truthy
    end

    fewer_times.each do |t|
      expect(options_fewer.times.find do |display_pair|
        display_pair.last.to_i == t
      end).to be_truthy
    end

  end

  it "dynamically returns available cities" do
    cities = ["Aurora", "Denver", "Boulder", "Westminster", "Broomfield"]
    cities_fewer = cities[0..1]
    cities.each { |c| FactoryGirl.create :meeting, city: c }

    options_all = SearchOptions.new
    options_fewer = SearchOptions.new(Meeting.where(city: cities_fewer))

    expect(options_all.cities.length).to eq(cities.length)
    expect(options_fewer.cities.length).to eq(cities_fewer.length)
    expect(options_all.cities.sort).to eq(cities.sort)
    expect(options_fewer.cities.sort).to eq(cities_fewer.sort)
  end

  it "dynamically returns time ranges" do
    times = [*5..23]
    times.each { |t| FactoryGirl.create :meeting, time: t }

    ["any", "now"].each do |range|
      expect(SearchOptions.new.times_select.to_a.flatten.include? range)
      .to be_truthy
    end

    no_morning = Meeting.where("time > ? ", 11.0)
    actual_times = SearchOptions.new(no_morning).times_select
    expect(actual_times.to_a.flatten.include? "am").to be_falsey

    no_noon = Meeting.where("time < ? OR time > ?", 10.0, 16.0)
    actual_times = SearchOptions.new(no_noon).times_select
    expect(actual_times.to_a.flatten.include? "noon").to be_falsey
    expect(actual_times.to_a.flatten.include? "am")

    # i could test the rest of these, but i don't want it to be more brittle
    # than it already is. meaning, who says i'm going to keep the number and
    # definition of ranges the way they are today? this will break. i'm
    # not going to break it any harder than it will already in such a case.
  end

  it "dynamically returns mens" do
    meeting = FactoryGirl.create :meeting
    focus = Focus.where(name: "Men").first
    meeting.update_attribute(:foci, [focus])

    FactoryGirl.create_list :meeting, 3
    expect(Meeting.includes(:foci).where(foci: { name: "Men" }).count).to eq(1)

    options = SearchOptions.new
    expect(options.focus_select.include? "Men").to be_truthy

    options = SearchOptions.new(Meeting.where.not(foci: { name: "Men"}))
    expect(options.focus_select.include? "Men").to be_falsey
  end

  it "dynamically returns language" do
    meeting = FactoryGirl.create :meeting
    language = Language.where(name: "Spanish")
    meeting.update_attribute(:languages, language)

    FactoryGirl.create_list :meeting, 3
    expect(Meeting.includes(:languages)
      .where(languages: { name: "Spanish" }).count).to eq(1)

    options = SearchOptions.new
    expect(options.language_select.include? "Spanish").to be_truthy

    options = SearchOptions.new(Meeting.where.not(languages: { name: "Spanish"}))
    expect(options.language_select.include? "Spanish").to be_falsey
  end

end
