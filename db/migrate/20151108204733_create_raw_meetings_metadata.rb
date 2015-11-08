class CreateRawMeetingsMetadata < ActiveRecord::Migration
  def change
    create_table :raw_meetings_metadata do |t|
      t.datetime :last_update
    end
  end
end
