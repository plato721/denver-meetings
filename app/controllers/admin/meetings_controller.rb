class Admin::MeetingsController < AdminController
  def index
    @meetings = Meeting.all.map { |m| AdminMeetingDisplay.new(m) }
  end

  def edit
    @meeting = Meeting.find(params[:id])
  end

  def update
    @meeting = Meeting.find(params[:id])

    address_success = @meeting.address.update(address_params)
    meeting_success = @meeting.update(meeting_params)
    if address_success && meeting_success
      flash[:success] = "Meeting updated successfully"
      redirect_to admin_meetings_path
    else
      flash[:danger] = "Unable to update meeting: \
        #{@meeting.errors.full_messages.concat(
          @meeting.address.errors.full_messages
        ).join(", ")}"
      redirect_to edit_admin_meeting_path
    end
  end

  private
  def meeting_params
    params.permit(
      :group_name,
      :day,
      :phone,
      :approved,
      :time,
    )
  end

  def address_params
    params.permit(
      :lat,
      :lng,
      :address_1,
      :address_2,
      :city,
      :zip,
      :notes,
    )
  end
end
