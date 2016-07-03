class ScrapeDaccaa
  attr_reader :force, :headers, :raw_rows, :meta
  attr_accessor :raw_meetings, :parsed

  def initialize(force=false, page=nil)
    @force = force
    page ||= self.get_page
    noko_page = noko_page(page)
    @headers = DaccaaHeaders.new(noko_page)
    @raw_rows = RawRows.new(noko_page)
    @meta = DaccaaMeta.new(noko_page)
  end

  def self.scrape(force=false)
    scraper = self.new(force)
    scraper.tap { |s| s.raw_meetings = s.make_meetings(scraper.parsed) }
  end

  def make_meetings(parsed)
    return false if !update_needed?
    return false if !valid_headers?
    current_raw = create_raw_meetings
    self.meta.set_updated
    current_raw
  end

  def update_needed?
    @meta.update_needed? || self.force
  end

  def valid_headers?
    puts "<------Checking that Dacaa Headers match expected------->"
    if @headers.valid?
      puts "Done!"
      true
    else
      Rails.logger.error "Bad Headers: #{@headers.retrieved_headers}"
      false
    end
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

  def noko_page(page)
    Nokogiri::HTML(page)
  end

  def create_raw_meetings
    self.raw_rows.each_with_object([]) do |row, meetings|
      meetings << RawMeeting.add_from(row)
    end
  end

  def inspect
    {
      "headers: " => "#{self.headers.object_id}",
      "rows: " => "#{self.raw_rows.object_id}: #{self.raw_rows.count} rows"
    }
  end

end
