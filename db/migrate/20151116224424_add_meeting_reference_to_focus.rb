class AddMeetingReferenceToFocus < ActiveRecord::Migration
  def change
    add_reference :foci, :meeting, index: true, foreign_key: true
  end
end
