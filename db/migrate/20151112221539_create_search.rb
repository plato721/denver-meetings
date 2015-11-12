class CreateSearch < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.citext      :free
      t.string      :city
      t.string      :group_name
      t.string      :day
      t.string      :time
      t.string      :open
    end
  end
end
