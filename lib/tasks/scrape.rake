namespace :daccaa do
  desc "scrape daccaa for meetings"
  task :get_data, [:force] => :environment do |t, args|
    force = args[:force]
    update(force)
  end

  def update(force)
    scraper = ScrapeDaccaa.scrape(force)
    return no_updates_needed if !scraper.raw_meetings

    # As long as force was set to true, or if the timestamp applies,
    # we get here with raw meetings --> all of them for everything
    creator = MeetingsCreator.new(scraper.raw_meetings)
    creator.run_updates
  end

  def no_updates_needed
    puts "No updates needed. Pass 'true' to get_data to force update."
  end

end

task update: 'daccaa:get_data'
