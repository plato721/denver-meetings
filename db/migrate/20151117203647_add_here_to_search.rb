class AddHereToSearch < ActiveRecord::Migration[4.2]
  def change
    add_column :searches, :here, :boolean, default: false
  end
end
