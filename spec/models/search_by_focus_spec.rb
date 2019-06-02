require 'rails_helper'

RSpec.describe "Search by language" do
  include_context "search"
  include_context "codes"

  before :all do
    Meeting.destroy_all
    FactoryBot.create_list :meeting, 3
  end

  context "men" do
    before do
      Meeting.first.tap{ |m| m.update_attributes(
        men: true,
        women: true
      )}.save
      Meeting.second.tap{ |m| m.update_attributes(
        women: true,
        young_people: true
      )}.save
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
      Meeting.first.tap{ |m| m.update_attributes(
        men: true,
        women: true
      )}.save
      Meeting.second.tap{ |m| m.update_attributes(
        men: true,
        young_people: true
      )}.save
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
      Meeting.first.tap{ |m| m.update_attributes(
        young_people: true,
        women: true
      )}.save
      Meeting.second.tap{ |m| m.update_attributes(
        men: true,
        women: true
      )}.save
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

 context "gay" do
    before do
      Meeting.first.tap{ |m| m.update_attributes(
        gay: true,
        women: true
      )}.save
      Meeting.second.tap{ |m| m.update_attributes(
        men: true,
        women: true
      )}.save
    end

    it "finds only" do
      params = default_params.merge("gay" => "only")

      meetings = Search.new(params).results
      count = meeting_count(meetings)

      expect(meetings.count).to eq(1)
    end

    it "finds both" do
      params = default_params.merge("gay" => "show")

      meetings = Search.new(params).results
      count = meeting_count(meetings)

      expect(count).to eq(3)
    end

    it "hides" do
      params = default_params.merge("gay" => "hide")

      meetings = Search.new(params).results
      count = meeting_count(meetings)

      expect(count).to eq(2)
    end
  end

end
