class ChangeAddress1ToCiText < ActiveRecord::Migration
  def change
    change_column :meetings, :address_1, :citext
  end
end
