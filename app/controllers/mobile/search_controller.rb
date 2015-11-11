class Mobile::SearchController < ApplicationController
  layout "mobile"

  def new
    @request = SearchRequest.new
    @options = SearchOptions.new
  end

  def index
    @meetings = Meeting.all.take(10)
  end

  def create
    @search_request = SearchRequest.create_request(request_params)
    session[:search_request] = @search_request.id
    redirect_to mobile_search_index_path
  end

  private
  def request_params
    {}.merge(params)
  end

end
