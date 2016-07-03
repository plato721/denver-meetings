class Language < ActiveRecord::Base
  validate :uses_only_permitted_languages
  validates :code, uniqueness: true
  validates :name, uniqueness: true
  has_many :meeting_languages
  has_many :meetings, through: :meeting_languages  

  def self.get_languages(codes)
    permitted_languages.each_with_object({}) do |(code, language), results|
      results[language] = codes.include? code
    end
  end

  def self.permitted_languages
    {"Spn" => :spanish,
     "Frn" => :french,
     "Pol" => :polish}
  end
end
