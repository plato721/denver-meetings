require 'rails_helper'

describe DaccaaMeta do

  before :all do
    page = File.read("spec/support/raw_page.txt")
    @scraper = ScrapeDaccaa.new(false, page)
    @noko_page = @scraper.noko_page(page)
    @now = DateTime.now
    @yesterday = @now.yesterday
    @tomorrow = @now.tomorrow
    dates = [@now, @yesterday, @tomorrow].shuffle.shuffle

    dates.each do |date|
      RawMeetingMetadata.create(last_update: date)
    end
  end

  it "needs a noko page" do
    expect{ DaccaaMeta.new([]) }.to raise_error(ArgumentError)
  end

  it "knows when local (denver meetings) was updated" do
    meta = DaccaaMeta.new(@noko_page)

    result = DateTime.parse(meta.local_updated.to_s)
    compare = DateTime.parse(@tomorrow.to_s)

    expect(result).to eq(compare)
  end

  it "knows when remote (daccaa) was updated" do
    # this is in the raw page file
    meta = DaccaaMeta.new(@noko_page)

    expected = DateTime.parse("2016-06-15T16:59:56+00:00")
    actual = meta.remote_updated

    expect(actual).to eq(expected)
  end

  it "wants to update when local updated older than remote" do
    meta = DaccaaMeta.new(@noko_page)

    allow_any_instance_of(DaccaaMeta).to receive(:local_updated)
      .and_return(@yesterday)
    allow_any_instance_of(DaccaaMeta).to receive(:remote_updated)
      .and_return(@tomorrow)

    expect(meta.update_needed?).to be_truthy
  end

  it "won't update if the updates weigh the same" do
    meta = DaccaaMeta.new(@noko_page)

    allow_any_instance_of(DaccaaMeta).to receive(:local_updated)
      .and_return(@now)
    allow_any_instance_of(DaccaaMeta).to receive(:remote_updated)
      .and_return(@now)

    expect(meta.update_needed?).to be_falsey
  end
end