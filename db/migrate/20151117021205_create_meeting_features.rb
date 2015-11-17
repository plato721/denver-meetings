class CreateMeetingFeatures < ActiveRecord::Migration
  def change
    create_table :meeting_features do |t|
      t.integer :meeting_id
      t.integer :feature_id
    end
  end
end
