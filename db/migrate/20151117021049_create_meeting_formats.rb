class CreateMeetingFormats < ActiveRecord::Migration
  def change
    create_table :meeting_formats do |t|
      t.integer :meeting_id
      t.integer :format_id
    end
  end
end
