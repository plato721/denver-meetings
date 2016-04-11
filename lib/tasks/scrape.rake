namespace :daccaa do
  desc "scrape daccaa for meetings"
  task :get_data, [:force] => :environment do |t, args|
    force = args[:force]
    scraper = ScrapeDaccaa.scrape(force)
    creator = MeetingsCreator.new(scraper.raw_meetings)
    creator.update_displayable
  end


end
