class AddMeetingReferenceToFormat < ActiveRecord::Migration
  def change
    add_reference :formats, :meeting, index: true, foreign_key: true
  end
end
