class AddHereAndNowToSearch < ActiveRecord::Migration[4.2]
  def change
    add_column :searches, :here_and_now, :boolean
  end
end
