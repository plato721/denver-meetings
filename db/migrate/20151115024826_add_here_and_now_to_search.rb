class AddHereAndNowToSearch < ActiveRecord::Migration
  def change
    add_column :searches, :here_and_now, :boolean
  end
end
