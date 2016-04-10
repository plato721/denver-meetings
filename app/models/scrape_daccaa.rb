class ScrapeDaccaa
  attr_reader :parsed, :force

  def initialize(force=false)
    @force = force
    @parsed = []
  end

  def self.scrape(force=false)
    scraper = self.new(force)
    scraper.set_parsed
    scraper.update_meetings
  end

  def set_parsed
    @parsed = parse_meetings(get_page)
  end

  def update_meetings
    return false if !update_needed?
    create_raw_meetings(self.parsed)
    create_displayable_meetings
    set_updated
  end

  def url
    url = "http://www.daccaa.org/query.asp"
  end

  def get_page
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

  def local_updated
    RawMeetingMetadata.order(last_update: 'DESC').first.last_update
  end

  def remote_updated
    raw = self.parsed.find { |e| e.include? "Database Last Updated" }
    raw = raw.slice(22..-1)
    DateTime.strptime(raw, "%m/%d/%Y %I:%M:%S %p")
  end

  def set_updated
    RawMeetingMetadata.create(last_update: remote_updated)
  end

  def update_needed?
    local_updated < remote_updated || self.force
  end

  def headers_raw_meetings
    ["Day", "Time", "Group Name", "Address", "City", "District", "Codes"]
  end

  def rest_raw_meetings(data=self.parsed)
    data[13..-68]
  end

  def create_raw_meetings(data=self.parsed)
    rest_raw_meetings.each_slice(7) do |slice|
      RawMeeting.add_from(slice)
    end
  end

  def raw_meetings_with_no_meetings
    have = Meeting.pluck(:raw_meeting_id)
    need = RawMeeting.where.not(id: have)
  end

  def create_displayable_meetings
    raw_meetings_with_no_meetings do |raw|
      MeetingCreator.new(raw).create
      sleep 1.0
    end
  end

  def to_a
    set_parsed if @parsed.nil?
    rest_raw_meetings.each_slice(7).with_object([]) do |slice, array|
      array << headers_raw_meetings.zip(slice).to_h
    end
  end

  def dump_to_yaml
  end
end
