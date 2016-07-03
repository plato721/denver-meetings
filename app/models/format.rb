class Format
  def self.is_speaker?(codes)
    codes.include?("SP")
  end

  def self.is_step?(codes)
    codes.include?("ST")
  end

  def self.is_big_book?(codes)
    codes.include?("BB")
  end

  def self.is_grapevine?(codes)
    codes.include?("GV")
  end

  def self.is_traditions?(codes)
    codes =~ /(.*[^S]T.*)|(^T.*)/
  end

  def self.is_candlelight?(codes)
    codes.include?("CA")
  end

  def self.is_beginners?(codes)
    codes.include?("B") && (codes.count("B") != 2)
  end

  def self.get_formats(codes)
    format_methods.each_with_object({}) do |method, formats|
      formats[method] = !!self.send("is_#{method}?".to_sym, codes)
    end
  end

  def self.format_methods
    [:speaker, :step, :big_book, :grapevine,
      :traditions, :candlelight, :beginners]
  end

end
