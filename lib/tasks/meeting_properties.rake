def formats
  { O: "Open",
    C: "Closed",
   SP: "Speaker",
   ST: "Step",
   BB: "Big Book",
   GV: "Grapevine",
    T: "Traditions",
   CA: "Candlelight",
    B: "Beginners'"}
end

def load_formats
  formats.each do |code, format|
    Format.new(code: code,
            name: format)
  end
end

def features
  {ASL: "Sign Language Interpreter",
    "*": "Wheelchair",
    n: "Non-Smoking",
  Sit: "Sitter"}
end

def load_features
  features.each do |code, feature|
    Feature.new(code: code,
            name: feature)
  end
end

def focus
  {M: "Men",
  W: "Women",
  G: "Gay",
  Y: "Young People"}
end

def load_focus
  focus.each do |code, focus|
    Focus.new(code: code,
            name: focus)
  end
end

def languages
  {Spn: "Spanish",
   Frn: "French",
   Pol: "Polish"}
end

def load_languages
  languages.each do |code, language|
    Language.new(code: code,
            name: language)
  end
end


namespace :meetings do
  task :load_properties => :environment do
    load_languages
    load_focus
    load_features
    load_formats
  end
end