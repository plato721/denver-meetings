class AddLatAndLngToSearch < ActiveRecord::Migration
  def change
    add_column :searches, :lat, :decimal
    add_column :searches, :lng, :decimal
  end
end
