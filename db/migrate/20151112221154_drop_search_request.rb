class DropSearchRequest < ActiveRecord::Migration[4.2]
  def change
    drop_table :search_requests
  end
end
