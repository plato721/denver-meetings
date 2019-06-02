namespace :flags do
  desc "migrate column closed to flag is_closed"
  task :migrate_closed => :environment do
    Meeting.all.each do |meeting|
      meeting.is_closed = meeting.closed
      meeting.save
    end
  end


end
