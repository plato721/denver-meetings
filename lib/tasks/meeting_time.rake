namespace :meeting_time do
  task :add => :environment do
    meetings = Meeting.all
    meetings.each do |meeting|
      raw_time = meeting.raw_meeting.time
      dec_time = TimeConverter.to_dec(raw_time)
      meeting.update_attributes(time: dec_time)
    end
  end
end