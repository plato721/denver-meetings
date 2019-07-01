class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: user_params[:username])
    if user && user.authenticate(user_params[:password])
      session[:user_id] = user.id
      redirect_to admin_dashboard_path
    else
      flash[:danger] = "Unable to authenticate. Please try again."
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:success] = "Successfully logged out."
    redirect_to root_path
  end

  private
  def user_params
    params.permit(:username, :password)
  end
end
