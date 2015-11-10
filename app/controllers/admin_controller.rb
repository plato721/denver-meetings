class AdminController < ApplicationController
before_action :confirm_admin

  def admin?
    current_user && current_user.admin?
  end

  def confirm_admin
    if !current_user
      redirect_to login_path
    elsif admin?
      true
    else
      redirect_to unauthorized_path
    end
  end
end