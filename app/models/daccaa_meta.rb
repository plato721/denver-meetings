class DaccaaMeta
  attr_reader :noko_page

  def initialize(noko_page)
    validate(noko_page)
    @noko_page = noko_page
  end

  def validate(noko_page)
    if !(noko_page.is_a? Nokogiri::HTML::Document)
      raise ArgumentError, 
        "Expecting a Nokogiri object, but a #{noko_page.class} was received"
    end
  end

  def update_cell
    self.noko_page.search('//text()').to_a
    .find { |cell| cell.text() =~ /Updated/ }
  end

  def update_time(cell)
    cell.text().scan(/\d{1,2}:\d{1,2}:\d{1,2}\s{1}[A|P][M]/).pop
  end

  def update_date(cell)
    cell.text().scan(/\d{1,2}\/\d{1,2}\/\d{4}/).pop
  end

  def remote_updated
    cell = update_cell
    update_string = "#{update_date(cell)} #{update_time(cell)}"
    DateTime.strptime(update_string, "%m/%d/%Y %I:%M:%S %p")
  end

  def local_updated
    RawMeetingMetadata.order(last_update: 'DESC').first.last_update
  end

  def set_updated
    RawMeetingMetadata.create(last_update: remote_updated)
  end

  def update_needed?
    local_updated < remote_updated
  end

end