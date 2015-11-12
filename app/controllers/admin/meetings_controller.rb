class Admin::MeetingsController < AdminController
  def index
    @meetings = Meeting.all.to_a
  end

  def edit
    @meeting = Meeting.find(params[:id])
  end

  def update
    @meeting = Meeting.find(params[:id])
    if @meeting.update(meeting_params)
      flash[:success] = "Meeting updated successfully"
      redirect_to admin_meetings_path
    else
      flash[:danger] = "Unable to update meeting"
      redirect_to edit_admin_meeting_path
    end
  end

  private
  def meeting_params
    params.require(:meeting).permit(:group_name, :day, :lat,
      :lng, :approved, :time, :address_1, :address_2, :city,
      :zip, :notes, :phone)
  end
end
