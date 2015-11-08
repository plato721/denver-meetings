class CreateRawMeetings < ActiveRecord::Migration
  def change
    create_table :raw_meetings do |t|
      t.string :day
      t.string :group_name
      t.string :address
      t.string :city
      t.string :district
      t.string :codes
      t.timestamps null: false
    end
  end
end
