class CreateMeetingFoci < ActiveRecord::Migration[4.2]
  def change
    create_table :meeting_foci do |t|
      t.integer :meeting_id
      t.integer :focus_id
    end
  end
end
