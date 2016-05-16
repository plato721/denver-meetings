class Mobile::SearchController < ApplicationController
  layout "mobile"

  def new
    @options = SearchOptions.new
  end

  def here_and_now
    search = Search.create(here_and_now_params)
    @meetings = search.results

    respond_to do |format|
      format.js { render 'index' }
    end
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

  def here_and_now_params
    { lat: params[:lat],
      lng: params[:lng],
      here_and_now: true
    }
  end

end
