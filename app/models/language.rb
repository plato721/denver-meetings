class Language
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

  def self.language_methods
    permitted_languages.values
  end
end
