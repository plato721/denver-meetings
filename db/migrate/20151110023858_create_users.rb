class CreateUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :users do |t|
      t.string    "uid"
      t.string    "nickname"
      t.string    "email"
      t.string    "name"
      t.string    "image"
      t.string    "token"
      t.integer   "role", default: 0
      t.timestamps null: false
    end
  end
end
