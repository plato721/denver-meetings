class Format < ActiveRecord::Base
  validate :uses_only_permitted_formats
  validates :code, uniqueness: true
  validates :name, uniqueness: true
  has_many :meeting_formats
  has_many :meetings, through: :meeting_formats

  def uses_only_permitted_formats
    if !Format.permitted_formats.keys.include?(code)
      errors.add(:code,
        "Must use code from #{Format.permitted_formats.keys}")
    elsif !Format.permitted_formats.values.include?(name)
      errors.add(:name,
        "Must use format name from #{Format.permitted_formats.values}")
    else
      true
    end
  end

  def self.get_speaker
    self.find_or_create_by(code: "SP") do |format|
      format.name = "Speaker"
    end
  end

  def self.match_speaker(codes)
    codes.include?("SP")
  end

  def self.get_step
    self.find_or_create_by(code: "ST") do |format|
      format.name = "Step"
    end
  end

  def self.match_step(codes)
    codes.include?("ST")
  end

  def self.get_big_book
    self.find_or_create_by(code: "BB") do |format|
      format.name = "Big Book"
    end
  end

  def self.match_big_book(codes)
    codes.include?("BB")
  end

  def self.get_grapevine
    self.find_or_create_by(code: "GV") do |format|
      format.name = "Grapevine"
    end
  end

  def self.match_grapevine(codes)
    codes.include?("GV")
  end

  def self.get_traditions
    self.find_or_create_by(code: "T") do |format|
      format.name = "Traditions"
    end
  end

  def self.match_traditions(codes)
    codes =~ /(.*[^S]T.*)|(^T.*)/
  end

  def self.get_candlelight
    self.find_or_create_by(code: "CA") do |format|
      format.name = "Candlelight"
    end
  end

  def self.match_candlelight(codes)
    codes.include?("CA")
  end

  def self.get_beginners
    self.find_or_create_by(code: "B") do |format|
      format.name = "Beginners"
    end
  end

  def self.match_beginners(codes)
    codes.include?("B") && (codes.count("B") != 2)
  end

  def self.get_formats(codes)
    get_format_methods.each_with_object([]) do |method, results|
      if self.send("match_#{method}".to_sym, codes)
        results << self.send("get_#{method}".to_sym)
      end
    end
  end

  def self.get_format_methods
    [:speaker, :step, :big_book, :grapevine,
      :traditions, :candlelight, :beginners]
  end

  def self.permitted_formats
    {"SP" => "Speaker",
    "ST" => "Step",
    "BB" => "Big Book",
    "GV" => "Grapevine",
    "T" => "Traditions",
    "CA" => "Candlelight",
    "B" => "Beginners"}
  end
end
