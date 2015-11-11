class Mobile::MeetingsController < ApplicationController
  layout "mobile"

  def index
    binding.pry
    @meetings = params[:meetings].to_a
  end
end