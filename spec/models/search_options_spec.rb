require 'rails_helper'

RSpec.describe SearchOptions do
  include_context "codes"

  before :all do
    @features = ["formats", "features", "foci", "languages"]
    @features.each do |feature|
      self.send("create_#{feature}".to_sym)
    end
  end

  after :all do
    @features.each do |f|
      f.singularize.capitalize.constantize.destroy_all
    end
  end

  before :each do
    Meeting.destroy_all
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

    expect(options_all.days_found_sorted).to eq(days)
    expect(options_narrowed.days_found_sorted).to eq(["Tuesday", "Thursday"])
  end

  it "dynamically returns clock time options" do
    times = [*18..24]
    times.each { |t| FactoryGirl.create :meeting, time: t }

    fewer_times = [19, 20]
    options_all = SearchOptions.new
    options_fewer = SearchOptions.new(Meeting.where(time: fewer_times))

    expect(options_all.times_found.length).to eq(times.length)
    expect(options_fewer.times_found.length).to eq(fewer_times.length)
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

    expect(options_all.cities_found.length).to eq(cities.length)
    expect(options_fewer.cities_found.length).to eq(cities_fewer.length)
    expect(options_all.cities_found.sort).to eq(cities.sort)
    expect(options_fewer.cities_found.sort).to eq(cities_fewer.sort)
  end

  it "dynamically returns time ranges" do
    times = [*5..23]
    times.each { |t| FactoryGirl.create :meeting, time: t }

    ["any", "now"].each do |range|
      expect(SearchOptions.new.times.to_a.flatten.include? range)
      .to be_truthy
    end

    no_morning = Meeting.where("time > ? ", 11.0)
    actual_times = SearchOptions.new(no_morning).time_ranges
    expect(actual_times.to_a.flatten.include? "am").to be_falsey

    no_noon = Meeting.where("time < ? OR time > ?", 10.0, 16.0)
    actual_times = SearchOptions.new(no_noon).time_ranges
    expect(actual_times.to_a.flatten.include? "noon").to be_falsey
    expect(actual_times.to_a.flatten.include? "am")

    # i could test the rest of these, but i don't want it to be more brittle
    # than it already is. meaning, who says i'm going to keep the number and
    # definition of ranges the way they are today? this will break. i'm
    # not going to break it any harder than it will already in such a case.
  end

  it "dynamically returns mens" do
    meeting = FactoryGirl.create :meeting
    focus = Focus.where(name: "Men")
    meeting.update_attribute(:foci, focus)

    FactoryGirl.create_list :meeting, 3
    expect(Meeting.includes(:foci).where(foci: { name: "Men" }).count).to eq(1)

    options = SearchOptions.new
    expect(options.foci.include? "Men").to be_truthy

    options = SearchOptions.new(Meeting.where.not(foci: { name: "Men"}))
    expect(options.foci.include? "Men").to be_falsey
  end

  it "dynamically returns language" do
    meeting = FactoryGirl.create :meeting
    language = Language.where(name: "Spanish")
    meeting.update_attribute(:languages, language)

    FactoryGirl.create_list :meeting, 3
    expect(Meeting.includes(:languages)
      .where(languages: { name: "Spanish" }).count).to eq(1)

    options = SearchOptions.new
    expect(options.languages.include? "Spanish").to be_truthy

    options = SearchOptions.new(Meeting.where.not(languages: { name: "Spanish"}))
    expect(options.languages.include? "Spanish").to be_falsey
  end

  it "dynamically return accessibility" do

    # features.each do |name|
    # expect(Meeting.includes(:features)
    #   .where(features: { name: name }).count).to eq(1)
    # end
  end

end
