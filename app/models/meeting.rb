class Meeting < ActiveRecord::Base
  attr_reader :geocoder
  attr_accessor :_skip_geocoder

  validate :raw_meeting_unique, on: :create
  validate :feature_unique, :focus_unique, :language_unique, :format_unique

  # geocoder dependent callbacks
  geocoded_by :address, :latitude => :lat, :longitude => :lng
  after_validation :geocode, :unless => :_skip_geocoder
  before_create :custom_reverse, :address_from_coords, :unless => :_skip_geocoder
  # end geocoder depened callbacks

  belongs_to :raw_meeting

  has_many :meeting_foci
  has_many :meeting_formats
  has_many :meeting_features
  has_many :meeting_languages
  has_many :features, through: :meeting_features
  has_many :foci, through: :meeting_foci
  has_many :formats, through: :meeting_formats
  has_many :languages, through: :meeting_languages

  def self.geocoded
    where.not(lat: nil).where.not(lng: nil)
  end

  def self.visible
    where(visible: true)
  end

  def self.open
    where(closed: false)
  end

  def self.closed
    where(closed: true)
  end

  def feature_unique
    if self.features.sort.uniq != self.features.sort
      errors.add(:feature, "must be unique")
    end
  end

  def focus_unique
    if self.foci.sort.uniq != self.foci.sort
      errors.add(:focus, "must be unique")
    end
  end

  def language_unique
    if self.languages.sort.uniq != self.languages.sort
      errors.add(:language, "must be unique")
    end
  end

  def format_unique
    if self.formats.sort.uniq != self.formats.sort
      errors.add(:format, "must be unique")
    end
  end

  def raw_meeting_unique
    # this allows a meeting to be created without
    #   a raw meeting. but if it's passed, must be unique.
    if Meeting.find_by(raw_meeting_id: raw_meeting_id)
      errors.add(:raw_meeting_id, "must be unique")
    end
  end

  def address
    [address_1, city, state].compact.join(', ')
  end

  def custom_reverse
    return if (!self.lat.present? || !self.lng.present?)
    @geocoder ||= Geocoder.search([self.lat, self.lng]).first
  end

  def address_from_coords
    return if !self.geocoder.present?
    self.zip = self.geocoder.postal_code
    self.address_1 = self.geocoder.street_address
  end

  def self.by_group_name(group_name)
    group_name == "any" ? all : where("group_name LIKE ?", "%#{group_name}%")
  end

  def self.by_city(city)
    city == "any" ? all : where("city LIKE ?", "%#{city}%")
  end

  def self.by_open(open)
    return all if open == "any"
    only = where(closed: true)
    open == "closed" ? only : where.not(id: only.map{|m| m.id} )
  end

  def self.by_day(day)
    day == "any" ? all : where("day LIKE ?", "%#{day}%")
  end

  def self.by_time(time)
    if SearchOptions.display_range_to_raw.keys.include?(time)
      return by_time_range(time)
    else
      time == "any" ? all : where(time: time)
    end
  end

  def self.by_time_range(range)
    range = SearchOptions.display_range_to_raw[range]
    where("time BETWEEN ? AND ?", range.first, range.second).order(:time)
  end

  def self.by_address_1(text)
    where("address_1 LIKE ?", text)
  end

  def self.by_gay(gay)
    return all if gay == "show"
    only = joins(:foci).where(foci: { name: "Gay" })
    gay == "only" ? only : where.not(id: only.map {|m| m.id} )
  end

  def self.by_youth(youth)
    return all if youth == "show"
    only = joins(:foci).where(foci: { name: "Young People" })
    youth == "only" ? only : where.not(id: only.map {|m| m.id} )
  end

  def self.by_women(women)
    return all if women == "show"
    only = joins(:foci).where(foci: { name: "Women" })
    women == "only" ? only : where.not(id: only.map {|m| m.id} )
  end

  def self.by_men(men)
    return all if men == "show"
    only = joins(:foci).where(foci: { name: "Men" })
    men == "only" ? only : where.not(id: only.map {|m| m.id} )
  end

  def self.by_polish(polish)
    return all if polish == "show"
    only = joins(:languages).where(languages: { name: "Polish" })
    polish == "only" ? only : where.not(id: only.map {|m| m.id} )
  end

  def self.by_spanish(spanish)
    return all if spanish == "show"
    only = joins(:languages).where(languages: { name: "Spanish" })
    spanish == "only" ? only : where.not(id: only.map {|m| m.id} )
  end

  def self.by_french(french)
    return all if french == "show"
    only = joins(:languages).where(languages: { name: "French" })
    french == "only" ? only : where.not(id: only.map {|m| m.id} )
  end

  def self.by_sitter(sitter)
    return all if sitter == "show"
    only = joins(:features).where(features: { name: "Sitter" })
    sitter == "only" ? only : where.not(id: only.map {|m| m.id} )
  end

  def self.by_access(access)
    return all if access == "show"
    only = joins(:features).where(features: { name: "Accessible" })
    access == "only" ? only : where.not(id: only.map {|m| m.id} )
  end

  def self.by_non_smoking(non_smoking)
    return all if non_smoking == "show"
    only = joins(:features).where(features: { name: "Non-Smoking" })
    non_smoking == "only" ? only : where.not(id: only.map {|m| m.id} )
  end

  def self.search(params)
    self
    .visible
    .by_group_name(params[:group_name])
    .by_group_name(params[:group_text])
    .by_city(params[:city])
    .by_city(params[:city_text])
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

end
