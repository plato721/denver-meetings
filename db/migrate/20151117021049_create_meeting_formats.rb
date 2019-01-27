class CreateMeetingFormats < ActiveRecord::Migration[4.2]
  def change
    create_table :meeting_formats do |t|
      t.integer :meeting_id
      t.integer :format_id
    end
  end
end
