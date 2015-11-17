class CreateFoci < ActiveRecord::Migration
  def change
    create_table :foci do |t|
      t.string :code
      t.string :name

      t.timestamps null: false
    end
  end
end
