class CreateFoci < ActiveRecord::Migration[4.2]
  def change
    create_table :foci do |t|
      t.string :code
      t.string :name

      t.timestamps null: false
    end
  end
end
