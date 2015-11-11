class Mobile::SearchController < ApplicationController
  layout "mobile"

  def new
    @options = SearchOptions.new
  end

  def create
    # get meetings
    meetings = Meeting.all
    redirect_to mobile_meetings_path(meetings: meetings)
  end
end
