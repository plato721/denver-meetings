require "rails_helper"
require "./lib/tasks/move_address/move_addresses"

describe MoveAddresses do
  it "creates addresses for non-deleted and visible meetings" do
    active = FactoryBot.create(:meeting, visible: true, deleted: false)
    FactoryBot.create(:meeting, visible: false, deleted: true)
    FactoryBot.create(:meeting, visible: true, deleted: true)
    FactoryBot.create(:meeting, visible: true, deleted: true)

    allow(MoveAddress).to receive(:call)
    described_class.call

    expect(MoveAddress).to have_received(:call).exactly(1).times.with(active)
  end
end