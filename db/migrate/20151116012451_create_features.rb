class CreateFeatures < ActiveRecord::Migration[4.2]
  def change
    create_table :features do |t|
      t.string :code
      t.string :name

      t.timestamps null: false
    end
  end
end
