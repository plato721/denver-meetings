class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    clear_bad_session # user_id not in database
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def clear_bad_session
    if session[:user_id] && !(User.exists?(id: session[:user_id]))
      session[:user_id] = nil
    end
  end
end
