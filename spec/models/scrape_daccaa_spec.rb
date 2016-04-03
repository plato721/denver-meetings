require 'rails_helper'

RSpec.describe ScrapeDaccaa do
  before(:all) do
    @scraper = ScrapeDaccaa.new
  end

  def valid?(url)
    !!URI.parse(url)
    rescue URI::InvalidURIError
      false
  end

  it "has a url" do
    scraper = ScrapeDaccaa.new

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

    it "knows when local (denver meetings) was updated" do
      result = DateTime.parse(@scraper.local_updated.to_s)
      compare = DateTime.parse(@tomorrow.to_s)

      expect(result).to eq(compare)
    end

    it "wants to update when local updated older than remote" do
      allow_any_instance_of(ScrapeDaccaa).to receive(:local_updated)
        .and_return(@yesterday)
      allow_any_instance_of(ScrapeDaccaa).to receive(:remote_updated)
        .and_return(@tomorrow)

      expect(@scraper.update_needed?).to be_truthy
    end

    it "wants to update when forced" do
      scrape = ScrapeDaccaa.new(true)
      unforced_scrape = ScrapeDaccaa.new

      allow_any_instance_of(ScrapeDaccaa).to receive(:local_updated)
        .and_return(@now)
      allow_any_instance_of(ScrapeDaccaa).to receive(:remote_updated)
        .and_return(@yesterday)

      expect(unforced_scrape.update_needed?).to be_falsey
      expect(scrape.update_needed?).to be_truthy
    end

    it "won't update if the updates weigh the same" do
      allow_any_instance_of(ScrapeDaccaa).to receive(:local_updated)
        .and_return(@now)
      allow_any_instance_of(ScrapeDaccaa).to receive(:remote_updated)
        .and_return(@now)

      expect(@scraper.update_needed?).to be_falsey
    end
  end
end
