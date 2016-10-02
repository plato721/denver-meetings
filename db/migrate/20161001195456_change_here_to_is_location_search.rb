class ChangeHereToIsLocationSearch < ActiveRecord::Migration
  def change
    rename_column :searches, :here, :is_location_search
  end
end
