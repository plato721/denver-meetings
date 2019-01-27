class CreateRawMeetingsMetadata < ActiveRecord::Migration[4.2]
  def change
    create_table :raw_meetings_metadata do |t|
      t.datetime :last_update
    end
  end
end
