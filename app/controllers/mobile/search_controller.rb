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

  def get_new_options
    search_params = { params[:source] => params[:selection] }
    search = Search.create(search_params)

    @options = SearchOptions.new(meetings: search.raw_meetings,
                                   source: params[:source])
    respond_to do |format|
      format.js { render 'options' }
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
      :method, :controller, :action, :authenticity_token, :utf8,
      :_, :format))
  end

  def here_and_now_params
    { lat: params[:lat],
      lng: params[:lon],
      here_and_now: true
    }
  end

end
