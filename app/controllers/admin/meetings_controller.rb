class Admin::MeetingsController < AdminController
  def index
    @meetings = Meeting.all.to_a
  end
end
