class RemoveGroupAndCityTextFromSearch < ActiveRecord::Migration[4.2]
  def change
    remove_column :searches, :group_text
    remove_column :searches, :city_text
  end
end
