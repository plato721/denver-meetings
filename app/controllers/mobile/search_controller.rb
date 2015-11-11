class Mobile::SearchController < ApplicationController
  layout "mobile"

  def new
    @options = SearchOptions.new
  end

  def create
  end
end
