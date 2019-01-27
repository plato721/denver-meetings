class AddWithinMilesToSearch < ActiveRecord::Migration[4.2]
  def change
    add_column :searches, :within_miles, :decimal
  end
end
