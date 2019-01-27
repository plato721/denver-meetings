class ChangeNotesToCiText < ActiveRecord::Migration[4.2]
  def change
    change_column :meetings, :notes, :citext
  end
end
