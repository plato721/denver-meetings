class DropFeaturesTables < ActiveRecord::Migration[4.2]
  def change
    drop_table :features
    drop_table :formats
    drop_table :foci
    drop_table :languages

    drop_table :meeting_features
    drop_table :meeting_formats
    drop_table :meeting_foci
    drop_table :meeting_languages
  end
end
