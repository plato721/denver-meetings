class Mobile::SearchController < ApplicationController
  layout "mobile"

  def new
    @options = SearchOptions.new
  end

  def index
    search = Search.find(session[:search]) if session[:search]
    @meetings = search.results.map{ |m| AdminMeetingDisplay.new(m) }
  end

  def create
    @search = Search.create_search(search_params)
    session[:search] = @search.id
    redirect_to mobile_search_index_path
  end

  private
  def search_params
    {}.merge(params)
  end

end
