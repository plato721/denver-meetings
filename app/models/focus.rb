class Focus < ActiveRecord::Base
  validate :uses_only_permitted_foci
  validates :code, uniqueness: true
  validates :name, uniqueness: true
  has_many :meeting_foci
  has_many :meetings, through: :meeting_foci

  def uses_only_permitted_foci
    if !Focus.permitted_foci.keys.include?(code)
      errors.add(:code,
        "Must use code from #{Focus.permitted_foci.keys}")
    elsif !Focus.permitted_foci.values.include?(name)
      errors.add(:name,
        "Must use focus name from #{Focus.permitted_foci.values}")
    end
  end

  def self.get_men
    self.find_or_create_by(code: "M") do |focus|
      focus.name = "Men"
    end
  end

  def self.match_men(codes)
    codes.include?("M")
  end

  def self.get_women
    self.find_or_create_by(code: "W") do |focus|
      focus.name = "Women"
    end
  end

  def self.match_women(codes)
    codes.include?("W")
  end

  def self.get_young_people
    self.find_or_create_by(code: "Y") do |focus|
      focus.name = "Young People"
    end
  end

  def self.match_young_people(codes)
    codes.include?("Y")
  end

  def self.get_gay
    self.find_or_create_by(code: "G") do |focus|
      focus.name = "Gay"
    end
  end

  def self.match_gay(codes)
    codes =~ /(G[^V]|.*G$)/
  end

  def self.get_foci(codes)
    get_focus_methods.each_with_object([]) do |method, results|
      if self.send("match_#{method}".to_sym, codes)
        results << self.send("get_#{method}".to_sym)
      end
    end
  end

  def self.get_focus_methods
    [:men, :women, :gay, :young_people]
  end

  def self.permitted_foci
    {"M" => "Men",
    "W" => "Women",
    "G" => "Gay",
    "Y" => "Young People"}
  end

end
