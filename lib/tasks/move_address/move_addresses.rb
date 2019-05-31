require './lib/tasks/move_address/move_address'

class MoveAddresses
  class << self
    def call
      active_meetings.each do |meeting|
        MoveAddress.call(meeting)
      end
    end

    def active_meetings
      Meeting.where(visible: true, deleted: false)
    end
  end
end
