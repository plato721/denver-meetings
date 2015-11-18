require 'rails_helper'

RSpec.describe "Search by access" do
  fixtures :meetings
  fixtures :features
  include_context "search"

  before do
    @non_smoking = Feature.find_by(name: "Non-Smoking")
    @accessible = Feature.find_by(name: "Accessible")
    @sitter = Feature.find_by(name: "Sitter")
  end

  context "non-smoking" do
    before do
      Meeting.first.features.push(@non_smoking, @accessible)
      Meeting.second.features.push(@accessible, @sitter)
    end

    it "finds only" do
      params = default_params.merge("non_smoking" => "only")

      meetings = Search.new(params).results
      count = meeting_count(meetings)

      expect(meetings.count).to eq(1)
    end

    it "finds both" do
      params = default_params.merge("non_smoking" => "show")

      meetings = Search.new(params).results
      count = meeting_count(meetings)

      expect(count).to eq(3)
    end

    it "hides" do
      params = default_params.merge("non_smoking" => "hide")

      meetings = Search.new(params).results
      count = meeting_count(meetings)

      expect(count).to eq(2)
    end

  end
end