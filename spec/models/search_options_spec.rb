require 'rails_helper'

RSpec.describe SearchOptions do
  before :each do
    allow_any_instance_of(Meeting).to receive(:geocode).and_return(nil)
  end

  it "is initialized with meetings or not" do
    FactoryGirl.create_list :meeting, 5
    meetings = Meeting.all

    options = SearchOptions.new
    options_narrowed = SearchOptions.new(meetings)

    ids = options.meetings.pluck(:id).sort
    ids_narrowed = options_narrowed.meetings.pluck(:id).sort

    expect(ids).to eq(ids_narrowed)
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



end
