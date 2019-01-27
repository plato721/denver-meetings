class CreateMeetingLanguages < ActiveRecord::Migration[4.2]
  def change
    create_table :meeting_languages do |t|
      t.integer :meeting_id
      t.integer :language_id
    end
  end
end
