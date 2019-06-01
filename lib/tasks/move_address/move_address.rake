require './lib/tasks/move_address/move_addresses'

namespace "address" do
  desc "Take the address attributes in Meeting and create an Address"
  task move_to_table: :environment do
    MoveAddresses.call
  end
end
