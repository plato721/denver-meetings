class Language < ActiveRecord::Base
  validate :uses_only_permitted_languages
  validates :code, uniqueness: true
  validates :name, uniqueness: true
  has_many :meeting_languages
  has_many :meetings, through: :meeting_languages  

  def uses_only_permitted_languages
    if !Language.permitted_languages.keys.include?(code)
      errors.add(:code,
        "Must use code from #{Language.permitted_languages.keys}")
    elsif !Language.permitted_languages.values.include?(name)
      errors.add(:name,
        "Must use language name from #{Language.permitted_languages.values}")
    else
      true
    end
  end

  def self.get_french
    self.find_or_create_by(code: "Frn") do |language|
      language.name = "French"
    end
  end

  def self.get_polish
    self.find_or_create_by(code: "Pol") do |language|
      language.name = "Polish"
    end
  end

  def self.get_spanish
    self.find_or_create_by(code: "Spn") do |language|
      language.name = "Spanish"
    end
  end

  def self.get_languages(codes)
    permitted_languages.each_with_object([]) do |language, results|
      if codes.include?(language.first)
        results << self.send("get_#{language.last.downcase}".to_sym)
      end
    end
  end

  def self.permitted_languages
    {"Spn" => "Spanish",
     "Frn" => "French",
     "Pol" => "Polish"}
  end
end
