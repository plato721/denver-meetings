class RemoveGroupAndCityTextFromSearch < ActiveRecord::Migration
  def change
    remove_column :searches, :group_text
    remove_column :searches, :city_text
  end
end
