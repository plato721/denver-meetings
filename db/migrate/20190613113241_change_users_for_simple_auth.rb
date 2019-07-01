class ChangeUsersForSimpleAuth < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :nickname
    remove_column :users, :image
    remove_column :users, :uid
    remove_column :users, :token
    add_column :users, :password_digest, :string
    add_column :users, :username, :string
  end
end
