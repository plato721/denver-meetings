class AddAddressToMeetings < ActiveRecord::Migration[5.2]
  def change
    add_column :meetings, :address_id, :int
  end
end
