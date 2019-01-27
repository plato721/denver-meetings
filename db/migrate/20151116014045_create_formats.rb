class CreateFormats < ActiveRecord::Migration[4.2]
  def change
    create_table :formats do |t|
      t.string  :code
      t.string  :name

      t.timestamps null: false
    end
  end
end
