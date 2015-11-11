def url
  url = "http://www.daccaa.org/query.asp"
end

def set_updated(data)
  updated = last_updated(data)
  RawMeetingMetadata.create(last_update: updated)
end

def last_updated(data)
  raw = data.find { |e| e.include? "Database Last Updated" }
  raw = raw.slice(22..-1)
  DateTime.strptime(raw, "%m/%d/%Y %I:%M:%S %p")
end

def update_meetings(data)
  trimmed = data.slice(13..-68)
  trimmed.each_slice(7) do |slice|
    RawMeeting.add_from(slice)
  end
end

def get_meetings_raw
  RestClient.post(url, {
  'txtGroup'=>'',
  'cboDay'=>'0',
  'cboStartTime'=>'All',
  'cboEndTime'=>'All',
  'txtCity'=>'',
  'cboMeetingType'=>'All',
  'cboMeetingFormat'=>'All',
  'cboSpecialMeeting'=>'All',
  'cboDistrict'=>'All',
  'cmdFindMeetings'=>'Find Meetings'
  })
end

def parse_meetings(page)
    npage = Nokogiri::HTML(page)
    data = npage.search('//text()').map(&:text).delete_if{|x| x !~ /\w|\*/}
    data = data.map {|ugly| ugly.lstrip} #remove leading whitespace
end

def create_displayable
  RawMeeting.all.each do |raw|
    if !Meeting.joins(:raw_meeting).exists?(raw.id)
      sleep 0.5
      MeetingCreator.new(raw).create
    end
  end
end

namespace :daccaa do
  task :get_data => :environment do
    page = get_meetings_raw
    data = parse_meetings(page)
    set_updated(data)
    update_meetings(data)
    create_displayable
  end
end