module SearchFocus

  def self.by_gay(gay)
    return all if gay == "show"
    if gay == "only"
      includes(:foci).where(foci: { name: "Gay" })
    elsif gay == "hide"
      includes(:foci).where(foci: { name: ["Young People", "Women", "Men", nil] })
    end
  end

  def self.by_youth(youth)
    return all if youth == "show"
    if youth == "only"
      includes(:foci).where(foci: { name: "Young People" })
    elsif youth == "hide"
      includes(:foci).where(foci: { name: ["Gay", "Women", "Men", nil] })
    end
  end

  def self.by_women(women)
    return all if women == "show"
    if women == "only"
      includes(:foci).where(foci: { name: "Women" })
    elsif women == "hide"
      includes(:foci).where(foci: { name: ["Gay", "Young People", "Men", nil] })
    end
  end

  def self.by_men(men)
    return all if men == "show"
    if men == "only"
      includes(:foci).where(foci: { name: "Men" })
    elsif men == "hide"
      includes(:foci).where(foci: { name: ["Gay", "Young People", "Women", nil] })
    end
  end

end
