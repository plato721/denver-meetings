class AdminController < ApplicationController
before_action :confirm_admin

  def confirm_admin
    if !current_user
      redirect_to login_path
    elsif current_user.admin?
      true
    else
      redirect_to unauthorized_path
    end
  end
end