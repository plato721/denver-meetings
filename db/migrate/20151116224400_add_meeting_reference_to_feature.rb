class AddMeetingReferenceToFeature < ActiveRecord::Migration
  def change
    add_reference :features, :meeting, index: true, foreign_key: true
  end
end
