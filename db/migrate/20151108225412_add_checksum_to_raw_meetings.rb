class AddChecksumToRawMeetings < ActiveRecord::Migration[4.2]
  def change
    add_column :raw_meetings, :checksum, :string
  end
end
