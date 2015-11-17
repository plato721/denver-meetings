def create_formats
  Format.get_format_methods.each do |method|
    Format.send(method)
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

def properties_methods
  [:load_languages, :load_foci, :load_features, :load_formats]
end

def properties_models
  {Focus => "foci",
    Format => "formats",
    Feature => "features",
    Language => "languages"}
end

def get_property_set_for(meeting, property)
  codes = meeting.raw_meeting.codes
  property.first.send("get_#{property.last}".to_sym, (codes))

end

def add_properties(meeting)
  properties_models.each do |property|
    properties = get_property_set_for(meeting, property)
    meeting.send(property.last.to_sym).concat(properties)
    meeting.save
  end
end

namespace :meetings do
  task :load_properties => :environment do
    Meeting.all.each do |meeting|
      add_properties(meeting)
    end
  end
end