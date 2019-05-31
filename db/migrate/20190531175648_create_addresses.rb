class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.citext "address_1"
      t.string "address_2"
      t.citext "notes"
      t.string "city"
      t.string "state"
      t.string "zip"
      t.string "district"
      t.decimal "lat", precision: 10, scale: 6
      t.decimal "lng", precision: 10, scale: 6
    end
  end
end
