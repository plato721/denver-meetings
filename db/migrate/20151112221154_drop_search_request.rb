class DropSearchRequest < ActiveRecord::Migration
  def change
    drop_table :search_requests
  end
end
