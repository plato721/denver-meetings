class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.string    :day
      t.string    :group_name
      t.string    :address_1
      t.string    :address_2
      t.string    :notes
      t.string    :city
      t.string    :state
      t.string    :zip
      t.string    :phone
      t.string    :district
      t.string    :codes
      t.decimal   :lat, {precision: 10, scale: 6}
      t.decimal   :lng, {precision: 10, scale: 6}

      t.timestamps null: false
    end
  end
end
