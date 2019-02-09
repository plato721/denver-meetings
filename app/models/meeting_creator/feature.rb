class MeetingCreator::Feature
  def self.is_asl?(codes)
    codes =~ /.*ASL.*/
  end

  def self.is_accessible?(codes)
    codes =~ /.*\*.*/
  end

  def self.is_non_smoking?(codes)
    codes =~ /(^n.*)|.*[^pr]n.*/
  end

  def self.is_sitter?(codes)
    codes =~ /.*Sit.*/
  end

  def self.feature_methods
    [:asl, :accessible, :non_smoking, :sitter]
  end

  def self.get_features(codes)
    feature_methods.each_with_object({}) do |method, features|
      features[method] = !!self.send("is_#{method}?".to_sym, codes)
    end
  end
end
