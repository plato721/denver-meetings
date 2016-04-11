class ScrapeDaccaa
  attr_reader :force
  attr_accessor :raw_meetings

  def initialize(force=false)
    @force = force
  end

  def self.scrape(force=false)
    scraper = self.new(force)
    page = scraper.get_page
    parsed = scraper.parse_meetings(page)
    scraper.tap { |s| s.raw_meetings = s.make_meetings(parsed) }
  end

  def make_meetings(parsed)
    return false if !update_needed?
    current_raw = create_raw_meetings(parsed)
    set_updated
    current_raw
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

  def rest_raw_meetings(parsed)
    parsed[13..-68]
  end

  def create_raw_meetings(parsed)
    rest_raw_meetings(parsed)
      .each_slice(7)
      .with_object([]) do |slice, meetings|
        meetings << RawMeeting.add_from(slice)
    end
  end

  # def to_a
  #   set_parsed if @parsed.nil?
  #   rest_raw_meetings.each_slice(7).with_object([]) do |slice, array|
  #     array << headers_raw_meetings.zip(slice).to_h
  #   end
  # end
end
