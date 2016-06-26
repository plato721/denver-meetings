class RawRows
  attr_reader :noko_page
  include Enumerable

  def initialize(noko_page)
    validate(noko_page)
    @noko_page = noko_page
  end

  def generate_rows
    noko_rows = noko_meeting_rows(self.noko_page)
    text_rows = self.text_rows(noko_rows)
    rows = day_time_filter(text_rows)
  end

  def validate(noko_page)
    if !(noko_page.is_a? Nokogiri::HTML::Document)
      raise ArgumentError, 
        "Expecting a Nokogiri object, but a #{noko_page.class} was received"
    end
  end

  def noko_meeting_rows(noko_page)
    self.noko_page.search('tbody tr')
  end

  def text_rows(noko_rows)
    # ["\r\n            Sunday", "\r\n            06:30 AM",...
    noko_rows.each_with_object([]) do |noko_row, text_rows|
      text_rows << noko_row.search('td').map { |r| r.text().lstrip }
    end
  end

  def rough_time
    /^\d{1,2}:\d{2}\s*(AM|PM|p|a)?$/
  end

  def day_time_filter(text_rows)
    text_rows.select do |tr|
      ( Day.day_order.include? tr.first ) &&
      ( !!(tr.second =~ self.rough_time) )
    end
  end

  def empty?
    list.empty?
  end

  def list
    list ||= begin
      generate_rows
    end
  end

  def each
    list.each do |row|
      yield row
    end
  end
end
