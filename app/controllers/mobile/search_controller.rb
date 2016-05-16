class Mobile::SearchController < ApplicationController
  layout "mobile"

  def new
    @options = SearchOptions.new
  end

  def create
    search = Search.create(search_params)
    @meetings = search.results

    respond_to do |format|
      format.js { render 'index' }
    end
  end

  private
  def search_params
    {}.merge(params.except("data-ajax", 
      :method, :controller, :action, :authenticity_token, :utf8))
  end

end
