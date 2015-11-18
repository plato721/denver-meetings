require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  fixtures :meetings

  it "generates cache key names" do
    label = "thumbnail"
    model = Meeting
    count = Meeting.count
    updated = Meeting.maximum(:updated_at)

    key = helper.cache_key_for(model, label)

    expect(key).to eq("meetings-thumbnail-#{count}-#{updated}")
  end
end
