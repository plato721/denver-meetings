class Focus

  def self.get_men
    self.find_or_create_by(code: "M") do |focus|
      focus.name = "Men"
    end
  end

  def self.is_men?(codes)
    codes.include?("M")
  end

  def self.is_women?(codes)
    codes.include?("W")
  end

  def self.is_young_people?(codes)
    codes.include?("Y")
  end

  def self.is_gay?(codes)
    codes =~ /(G[^V]|.*G$)/
  end

  def self.get_foci(codes)
    get_focus_methods.each_with_object({}) do |method, results|
      results[method] = self.send("is_#{method}?".to_sym, codes)
    end
  end

  def self.get_focus_methods
    [:men, :women, :gay, :young_people]
  end

end
