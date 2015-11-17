RSpec.shared_context "codes" do
  def valid_codes
    ["O", "C", "SP", "ST", "BB", "GV", "T", "CA",
      "Spn", "B", "M", "W", "G", "Y", "Frn", "Pol",
      "s", "ASL", "*", "n", "Sit"]
  end

  def create_formats
    Format.get_format_methods.each do |method|
      Format.send("get_#{method}".to_sym)
    end
  end

  def create_features
    Feature.get_feature_methods.each do |method|
      Feature.send("get_#{method}".to_sym)
    end
  end

def create_foci
  Focus.get_focus_methods.each do |method|
    Focus.send("get_#{method}".to_sym)
  end
end

def create_languages
  Language.permitted_languages.each do |code, name|
    Language.send("get_#{name.downcase}".to_sym)
  end
end

end