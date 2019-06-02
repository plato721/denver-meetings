class RemoveAddressAttributesFromMeeting < ActiveRecord::Migration[5.2]
  def change
    remove_column :meetings, :address_1
    remove_column :meetings, :address_2
    remove_column :meetings, :city
    remove_column :meetings, :state
    remove_column :meetings, :zip
    remove_column :meetings, :notes
    remove_column :meetings, :district
  end
end
