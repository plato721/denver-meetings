require 'rails_helper'

RSpec.describe "Search by language" do
  fixtures :meetings
  fixtures :foci
  include_context "search"

  before do
    @men = Focus.find_by(name: "Men")
    @women = Focus.find_by(name: "Women")
    @youth = Focus.find_by(name: "Young People")
    @gay = Focus.find_by(name: "Gay")
  end

  context "men" do
    before do
      Meeting.first.foci.push(@men, @women)
      Meeting.second.foci.push(@women, @youth)
    end

    it "finds only" do
      params = default_params.merge("men" => "only")

      meetings = Search.new(params).results
      count = meeting_count(meetings)

      expect(meetings.count).to eq(1)
    end

    it "finds both" do
      params = default_params.merge("men" => "show")

      meetings = Search.new(params).results
      count = meeting_count(meetings)

      expect(count).to eq(3)
    end

    it "hides" do
      params = default_params.merge("men" => "hide")

      meetings = Search.new(params).results
      count = meeting_count(meetings)

      expect(count).to eq(2)
    end
  end

  context "women" do
    before do
      Meeting.first.foci.push(@men, @women)
      Meeting.second.foci.push(@men, @youth)
    end

    it "finds only" do
      params = default_params.merge("women" => "only")

      meetings = Search.new(params).results
      count = meeting_count(meetings)

      expect(meetings.count).to eq(1)
    end

    it "finds both" do
      params = default_params.merge("women" => "show")

      meetings = Search.new(params).results
      count = meeting_count(meetings)

      expect(count).to eq(3)
    end

    it "hides" do
      params = default_params.merge("women" => "hide")

      meetings = Search.new(params).results
      count = meeting_count(meetings)

      expect(count).to eq(2)
    end

  end

 context "youth" do
    before do
      Meeting.first.foci.push(@youth, @women)
      Meeting.second.foci.push(@men, @women)
    end

    it "finds only" do
      params = default_params.merge("youth" => "only")

      meetings = Search.new(params).results
      count = meeting_count(meetings)

      expect(meetings.count).to eq(1)
    end

    it "finds both" do
      params = default_params.merge("youth" => "show")

      meetings = Search.new(params).results
      count = meeting_count(meetings)

      expect(count).to eq(3)
    end

    it "hides" do
      params = default_params.merge("youth" => "hide")

      meetings = Search.new(params).results
      count = meeting_count(meetings)

      expect(count).to eq(2)
    end
  end

end
