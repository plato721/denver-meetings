class WelcomeController < ApplicationController

  def faq
    params[:expand] = params[:expand].presence
  end

  def about
    
  end
end
