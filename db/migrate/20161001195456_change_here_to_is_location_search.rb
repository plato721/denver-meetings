class ChangeHereToIsLocationSearch < ActiveRecord::Migration[4.2]
  def change
    rename_column :searches, :here, :is_location_search
  end
end
