class Mobile::SearchController < ApplicationController
  protect_from_forgery except: :here_and_now
  layout "mobile"

  def new
    @options = SearchOptions.new
  end

  def here_and_now
    search = Search.create(here_and_now_params)
    @meetings = search.results

    respond_to do |format|
      format.html { render 'index' }
      format.js { render 'index' }
    end
  end

  def get_new_options
    search_params = { params[:source] => params[:selection] }
    search = Search.create(search_params)
    @options = SearchOptions.new(meetings: search.raw_meetings,
                                   source: params[:source])
    respond_to do |format|
      format.json { render json: @options }
    end
  end

  def create
    search = Search.create(search_params)
    @meetings = search.results
    if search.errors
      # the error will be to "free." won't make any sense
      # to the user to include this attribute name
      flash[:error] = search.errors.messages.map do |error_group|
        error_group.last.join("\n")
      end.join("\n")
    end

    respond_to do |format|
      format.js { render 'index' }
    end
  end

  private
  def search_params
    params.permit(permitted_params)
  end

  def here_and_now_params
    params.permit(:lat, :lng).merge(here_and_now: true)
  end

  def permitted_params
    [:free,
      :lat,
      :lng,
      :within_miles,
      :day,
      :time,
      :group_name,
      :city,
      :open,
      :men,
      :women,
      :youth,
      :gay,
      :access,
      :non_smoking,
      :sitter,
      :spanish,
      :polish,
      :french]
  end
end
