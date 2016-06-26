require 'rails_helper'

describe DaccaaHeaders do
  before :all do
    @page = File.read "spec/support/raw_page.txt"
    @invalid_page = File.read "spec/support/invalid_raw_page.txt"
    @scraper = ScrapeDaccaa.new
  end

  it "has headers" do
    noko_page = @scraper.noko_page(@page)
    dh = DaccaaHeaders.new(noko_page)

    expect(dh.headers).to be_truthy
    expect(dh.headers.class).to eq(Array)
  end

  it "is valid if headers are same" do
    noko_page = @scraper.noko_page(@page)
    dh = DaccaaHeaders.new(noko_page)

    expect(dh.valid?).to be_truthy
  end

  it "is not valid if headers are different" do
    noko_page = @scraper.noko_page(@invalid_page)
    dh = DaccaaHeaders.new(noko_page)

    expect(dh.valid?).to be_falsey
  end
end
