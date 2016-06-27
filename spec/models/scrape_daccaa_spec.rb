require 'rails_helper'

RSpec.describe ScrapeDaccaa do

  before(:all) do
    @page = File.read("spec/support/raw_page.txt")
    @scraper = ScrapeDaccaa.new(false, @page)
  end

  def valid?(url)
    !!URI.parse(url)
    rescue URI::InvalidURIError
      false
  end

  it "has a url" do
    scraper = ScrapeDaccaa.new true, @page

    expect(valid? scraper.url).to be_truthy
  end

  context "meeting update decision logic" do
    before(:all) do
      @now = DateTime.now
      @yesterday = @now.yesterday
      @tomorrow = @now.tomorrow
      dates = [@now, @yesterday, @tomorrow].shuffle.shuffle

      dates.each do |date|
        RawMeetingMetadata.create(last_update: date)
      end
    end

    it "wants to update when forced" do
      scrape = ScrapeDaccaa.new(true, @page)
      unforced_scrape = ScrapeDaccaa.new(false, @page)

      allow_any_instance_of(DaccaaMeta).to receive(:local_updated)
        .and_return(@now)
      allow_any_instance_of(DaccaaMeta).to receive(:remote_updated)
        .and_return(@yesterday)

      expect(unforced_scrape.update_needed?).to be_falsey
      expect(scrape.update_needed?).to be_truthy
    end

    it "collects raw meetings touched/created" do
        path = Rails.root + "spec/fixtures/raw_meetings.yml"
      yamls = RawMeeting.raw_from_yaml(path)
      raw = yamls.map do |id, data|
        [data["day"], data["time"], data["group_name"], data["address"], data["city"], data["district"], data["codes"]]
      end

      allow_any_instance_of(RawRows).to receive(:list).and_return(raw)
      scraper = ScrapeDaccaa.new(true, @page)
      raw_meetings = scraper.create_raw_meetings

      expect(raw_meetings.count).to eq(yamls.keys.count)
      expect(raw_meetings.all? { |o| o.is_a? RawMeeting }).to be_truthy
    end


  end
end
