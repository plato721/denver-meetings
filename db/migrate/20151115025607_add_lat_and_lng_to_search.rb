class AddLatAndLngToSearch < ActiveRecord::Migration[4.2]
  def change
    add_column :searches, :lat, :decimal
    add_column :searches, :lng, :decimal
  end
end
