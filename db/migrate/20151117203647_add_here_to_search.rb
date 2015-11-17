class AddHereToSearch < ActiveRecord::Migration
  def change
    add_column :searches, :here, :boolean, default: false
  end
end
