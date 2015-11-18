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

  it "finds only non-smoking meetings" do
    Meeting.first.features << @non_smoking
    params = default_params.merge("non_smoking" => "only")

    meetings = Search.new(params).results

    expect(meetings.count).to eq(1)
  end
end