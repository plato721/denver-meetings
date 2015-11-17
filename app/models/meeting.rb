class Meeting < ActiveRecord::Base

  geocoded_by :address, :latitude => :lat, :longitude => :lng
  after_validation :geocode
  before_create :address_from_coords
  belongs_to :raw_meeting
  has_many :meeting_foci
  has_many :meeting_formats
  has_many :meeting_features
  has_many :meeting_languages
  has_many :features, through: :meeting_features
  has_many :foci, through: :meeting_foci
  has_many :formats, through: :meeting_formats
  has_many :languages, through: :meeting_languages

  def self.search(params)
    by_group_name(params[:group_name])
    .by_city(params[:city])
    .by_day(params[:day])
    .by_time(params[:time])
    .by_open(params[:open])
    .by_youth(params[:youth])
    .by_gay(params[:gay])
    .by_men(params[:men])
    .by_women(params[:women])
    .by_polish(params[:polish])
    .by_french(params[:french])
    .by_spanish(params[:spanish])
    .by_sitter(params[:sitter])
    .by_access(params[:access])
    .by_non_smoking(params[:non_smoking])
    .distinct
  end

  def self.by_group_name(group_name)
    group_name == "Any" ? all : where("group_name LIKE ?", "%#{group_name}%")
  end

  def self.by_open(open)
    return all if open == "any"
    if open == "closed"
      where(closed: true)
    elsif open == "open"
      where.not(closed: true)
    end
  end

  def self.by_city(city)
    city == "Any" ? all : where("city LIKE ?", "%#{city}%")
  end

  def self.by_day(day)
    day == "Any" ? all : where("day LIKE ?", "%#{day}%")
  end

  def self.by_city(city)
    city == "Any" ? all : where("city LIKE ?", "%#{city}%")
  end

  def self.by_time(time)
    if SearchOptions.display_range_to_raw.keys.include?(time)
      return by_time_range(time)
    else
      time == "Any" ? all : where(time: time)
    end
  end

  def self.by_time_range(range)
    range = SearchOptions.display_range_to_raw[range]
    where("time BETWEEN ? AND ?", range.first, range.second).order(:time)
  end

  def self.by_address_1(text)
    where("address_1 LIKE ?", text)
  end

  def address
    [address_1, city, state].compact.join(', ')
  end

  def geocoder
    geocoder ||= begin
      if lat && lng
        Geocoder.search([self.lat, self.lng])
        .first.data["address_components"]
      else
        [][]
      end
    end
  end

  def calculated_zip
    zip ||= geocoder.last["long_name"]
  end

  def calculated_street_number
    num ||= geocoder[0]["long_name"]
  end

  def calculated_street_name
    name ||= geocoder[1]["short_name"]
  end

  def address_from_coords
    self.zip = calculated_zip
  end

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

  def self.by_polish(polish)
    return all if polish == "show"
    if polish == "only"
      includes(:languages).where(languages: { name: "Polish" })
    elsif polish == "hide"
      includes(:languages).where(languages: { name: ["Spanish", "French", nil] })
    end
  end

  def self.by_spanish(spanish)
    return all if spanish == "show"
    if spanish == "only"
      includes(:languages).where(languages: { name: "Spanish" })
    elsif spanish == "hide"
      includes(:languages).where(languages: { name: ["Polish", "French", nil] })
    end
  end

  def self.by_french(french)
    return all if french == "show"
    if french == "only"
      includes(:languages).where(languages: { name: "French" })
    elsif french == "hide"
      includes(:languages).where(languages: { name: ["Polish", "Spanish", nil] })
    end
  end

  def self.by_sitter(sitter)
    return all if sitter == "show"
    if sitter == "only"
      includes(:features).where(features: { name: "Sitter" })
    elsif sitter == "hide"
      includes(:features)
      .where(features: { name: ["Accessible", "Non-Smoking", "Sign Language Interpreter", nil] })
    end
  end

  def self.by_access(access)
    return all if access == "show"
    if access == "only"
      includes(:features).where(features: { name: "Accessible" })
    elsif access == "hide"
      includes(:features)
      .where(features: { name: ["Sitter", "Non-Smoking", "Sign Language Interpreter", nil] })
    end
  end

  def self.by_non_smoking(non_smoking)
    return all if non_smoking == "show"
    if non_smoking == "only"
      includes(:features).where(features: { name: "Non-Smoking" })
    elsif non_smoking == "hide"
      includes(:features)
      .where(features: { name: ["Sitter", "Accessible", "Sign Language Interpreter", nil] })
    end
  end

end
