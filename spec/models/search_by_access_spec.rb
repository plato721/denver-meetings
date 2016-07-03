require 'rails_helper'

RSpec.describe "Search by access" do
  include_context "search"
  include_context "codes"

  before :all do
    Meeting.destroy_all
    FactoryGirl.create_list :meeting, 3
  end

  before :each do
    no_geocode
  end

  after :all do
    Meeting.destroy_all
  end

  context "non-smoking" do
    before do
      Meeting.first.update_attribute(:non_smoking, true)
      Meeting.second.update_attribute(:accessible, true)
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

  context "accessible" do
    before do
      Meeting.first.tap{ |m| m.update_attributes(
        non_smoking: true,
        accessible: true
      )}.save
      Meeting.second.tap{ |m| m.update_attributes(
        non_smoking: true,
        sitter: true
      )}.save
    end

    it "finds only" do
      params = default_params.merge("access" => "only")

      meetings = Search.new(params).results
      count = meeting_count(meetings)

      expect(meetings.count).to eq(1)
    end

    it "finds both" do
      params = default_params.merge("access" => "show")

      meetings = Search.new(params).results
      count = meeting_count(meetings)

      expect(count).to eq(3)
    end

    it "hides" do
      params = default_params.merge("access" => "hide")

      meetings = Search.new(params).results
      count = meeting_count(meetings)

      expect(count).to eq(2)
    end

  end

 context "sitter" do
    before do
      Meeting.first.tap{ |m| m.update_attributes(
        non_smoking: true,
        accessible: true )}.save
      Meeting.second.tap{ |m| m.update_attributes(
        non_smoking: true,
        sitter: true )}.save
    end

    it "finds only" do
      params = default_params.merge("sitter" => "only")

      meetings = Search.new(params).results
      count = meeting_count(meetings)

      expect(meetings.count).to eq(1)
    end

    it "finds both" do
      params = default_params.merge("sitter" => "show")

      meetings = Search.new(params).results
      count = meeting_count(meetings)

      expect(count).to eq(3)
    end

    it "hides" do
      params = default_params.merge("sitter" => "hide")

      meetings = Search.new(params).results
      count = meeting_count(meetings)

      expect(count).to eq(2)
    end
  end

end
