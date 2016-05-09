namespace :daccaa do
  desc "scrape daccaa for meetings"
  task :get_data, [:force] => :environment do |t, args|
    force = args[:force]
    scraper = ScrapeDaccaa.scrape(force)
    creator = MeetingsCreator.new(scraper.raw_meetings)
    creator.run_updates
  end

  desc "uniqueify properties for meetings"
  task :dedup_props => :environment do |t|
    props = [:foci, :features, :languages, :formats]
    Meeting.all.each do |meeting|
      dedup(meeting, props)
    end
  end

  def dedup(meeting, props)
    props.each do |property|
      initial = meeting.send(property)
      final = initial.uniq
      meeting.send(property).clear
      meeting.update_attribute(property, final)
    end
  end

end
