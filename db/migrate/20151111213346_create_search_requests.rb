class CreateSearchRequests < ActiveRecord::Migration[4.2]
  def change
    create_table :search_requests do |t|
      t.string :text
      t.string :city
      t.string :name
      t.string :time
      t.string :open
    end
  end
end
