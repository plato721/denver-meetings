class DaccaaHeaders
  attr_reader :noko_page

  def initialize(noko_page)
    validate(noko_page)
    @noko_page = noko_page
  end

  def validate(noko_page)
    if !(noko_page.is_a?(Nokogiri::HTML::Document))
      raise ArgumentError, "Expecting a Nokogiri object"
    end
  end

  def retrieved_headers
    self.noko_page.search('th').map do |header_cell|
      header_cell.text().scan(/\b\w+\b/).join(" ")
    end
  end

  def headers
    ["Day", "Time", "Group Name", "Address", "City", "District", "Codes"]
  end

  def valid?
    headers == retrieved_headers
  end
end
