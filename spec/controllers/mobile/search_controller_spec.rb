require 'rails_helper'

RSpec.describe Mobile::SearchController, type: :controller do
  before :all do
    Meeting.destroy_all
    FactoryGirl.create_list :meeting, 3
  end

  it "#new" do
    get :new

    options = assigns(:options)
    expect(options.is_a? SearchOptions).to be_truthy
  end

  context "#get_new_options" do
    it "responds" do
      get :get_new_options, { source: "day", options: "Monday", format: :json }

      expect(response).to have_http_status(200)
    end

    it "get new json-ready options" do
      get :get_new_options, { source: "day", options: "Monday", format: :json }

      result = assigns(:options).as_json.with_indifferent_access

      expect(result[:count] > 0).to be_truthy
      expect(result[:source]).to eq("day")
      expect(result[:options]).to be_truthy
    end
  end
end
