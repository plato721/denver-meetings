class ChangeNotesToCiText < ActiveRecord::Migration
  def change
    change_column :meetings, :notes, :citext
  end
end
