class RemoveLatLngFromMeetings < ActiveRecord::Migration[5.2]
  def change
    remove_column :meetings, :lat
    remove_column :meetings, :lng
  end
end
