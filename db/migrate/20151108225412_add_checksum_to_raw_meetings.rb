class AddChecksumToRawMeetings < ActiveRecord::Migration
  def change
    add_column :raw_meetings, :checksum, :integer
  end
end
