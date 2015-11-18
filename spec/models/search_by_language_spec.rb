require 'rails_helper'

RSpec.describe "Search by language" do
  fixtures :meetings
  fixtures :languages
  include_context "search"

  before do
    @polish = Language.find_by(name: "Polish")
    @french = Language.find_by(name: "French")
    @spanish = Language.find_by(name: "Spanish")
  end

  context "Polish" do
    before do
      Meeting.first.languages.push(@polish, @french)
      Meeting.second.languages.push(@french, @spanish)
    end

    it "finds only" do
      params = default_params.merge("polish" => "only")

      meetings = Search.new(params).results
      count = meeting_count(meetings)

      expect(meetings.count).to eq(1)
    end

    it "finds both" do
      params = default_params.merge("polish" => "show")

      meetings = Search.new(params).results
      count = meeting_count(meetings)

      expect(count).to eq(3)
    end

    it "hides" do
      params = default_params.merge("polish" => "hide")

      meetings = Search.new(params).results
      count = meeting_count(meetings)

      expect(count).to eq(2)
    end
  end

  context "French" do
    before do
      Meeting.first.languages.push(@polish, @french)
      Meeting.second.languages.push(@polish, @spanish)
    end

    it "finds only" do
      params = default_params.merge("french" => "only")

      meetings = Search.new(params).results
      count = meeting_count(meetings)

      expect(meetings.count).to eq(1)
    end

    it "finds both" do
      params = default_params.merge("french" => "show")

      meetings = Search.new(params).results
      count = meeting_count(meetings)

      expect(count).to eq(3)
    end

    it "hides" do
      params = default_params.merge("french" => "hide")

      meetings = Search.new(params).results
      count = meeting_count(meetings)

      expect(count).to eq(2)
    end

  end

 context "Spanish" do
    before do
      Meeting.first.languages.push(@polish, @french)
      Meeting.second.languages.push(@polish, @spanish)
    end

    it "finds only" do
      params = default_params.merge("spanish" => "only")

      meetings = Search.new(params).results
      count = meeting_count(meetings)

      expect(meetings.count).to eq(1)
    end

    it "finds both" do
      params = default_params.merge("spanish" => "show")

      meetings = Search.new(params).results
      count = meeting_count(meetings)

      expect(count).to eq(3)
    end

    it "hides" do
      params = default_params.merge("spanish" => "hide")

      meetings = Search.new(params).results
      count = meeting_count(meetings)

      expect(count).to eq(2)
    end
  end

end
