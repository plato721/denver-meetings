class Admin::AdminController < AdminController
  def index
    redirect_to admin_meetings_path
  end
end