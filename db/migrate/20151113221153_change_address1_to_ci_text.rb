class ChangeAddress1ToCiText < ActiveRecord::Migration[4.2]
  def change
    change_column :meetings, :address_1, :citext
  end
end
