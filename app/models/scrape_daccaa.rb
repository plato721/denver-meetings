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

  def create_raw_meetings(data)
    trimmed = data.slice(13..-68)
    trimmed.each_slice(7) do |slice|
      RawMeeting.add_from(slice)
    end
  end

  def create_displayable_meetings
    new_meetings = []
    RawMeeting.all.each do |raw|
      if !Meeting.joins(:raw_meeting).exists?(raw.id)
        sleep 1.0
        MeetingCreator.new(raw).create
      end
    end
  end
end