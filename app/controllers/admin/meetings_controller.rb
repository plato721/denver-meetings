class Admin::MeetingsController < AdminController
  def index
    @meetings = Meeting.all.to_a
  end

  def edit
    @meeting = Meeting.find(params[:id])
  end
end
