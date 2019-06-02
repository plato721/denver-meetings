RSpec.describe AdminMeetingDisplay do
  fixtures :meetings, :addresses

  it "creates a url to google maps using a meeting's coordinates" do
    amd = AdminMeetingDisplay.new(Meeting.first)

    expect(amd.map_url.include?("http:")).to be_truthy
  end
end