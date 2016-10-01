class AddWithinMilesToSearch < ActiveRecord::Migration
  def change
    add_column :searches, :within_miles, :decimal
  end
end
