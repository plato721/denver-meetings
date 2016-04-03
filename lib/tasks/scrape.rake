namespace :daccaa do
  desc "scrape daccaa for meetings"
  task :get_data, [:force] => :environment do |t, args|
    force = args[:force]
    scraper = ScrapeDaccaa.scrape(force)
  end
end