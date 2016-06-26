require 'rails_helper'

describe RawRows do
  before :all do
    @scraper = ScrapeDaccaa.new
    page = File.read("spec/support/raw_page.txt")
    @noko_page = @scraper.noko_page(page)
  end
  it "requires a nokogiri page" do
    expect{ RawRows.new([]) }.to raise_error(ArgumentError)
  end

  it "keeps meetings with a day and a time" do
    rows = RawRows.new(@noko_page)

    all_have_days = rows.all? do |row|
      Day.day_order.include? row.first
    end

    expect(rows.empty?).to be_falsey
    expect(all_have_days).to be_truthy
  end
end
