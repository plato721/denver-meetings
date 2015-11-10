class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(auth)
    if user
      session[:user_id] = user.id
      redirect_to admin_meetings_path
    else
      flash[:danger] = "Unable to authenticate. Please try again."
      redirect_to root_path
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:success] = "Successfully logged out."
    redirect_to root_path
  end

  private
  def auth
    request.env["omniauth.auth"]
  end
end
