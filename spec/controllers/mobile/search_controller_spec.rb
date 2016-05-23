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
    it "gets new options" do
      xhr :get, :get_new_options

      expect(response).to have_http_status(200)
    end

    it "does search" do
      text = Meeting.first.group_name
      xhr :get, :get_new_options, group_text: text

      options = assigns(:options)
      expect(options.count).to eq(1)
    end
  end
end
