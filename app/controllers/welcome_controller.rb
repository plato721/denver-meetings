class WelcomeController < ApplicationController
  def index
  end

  def faq
    params[:expand] = params[:expand].presence
  end

  def about
    
  end
end
