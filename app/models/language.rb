class Language < ActiveRecord::Base
  validate :uses_only_permitted_languages

  def uses_only_permitted_languages
    if !permitted_languages.keys.include?(code)
      errors.add(:code, "Must use code from #{permitted_languages.keys}")
    elsif !permitted_languages.values.include?(name)
      errors.add(:name, "Must use language name from #{permitted_languages.values}")
    end
  end

  def permitted_languages
    {Spn: "Spanish",
     Frn: "French",
     Pol: "Polish"}
  end
end
