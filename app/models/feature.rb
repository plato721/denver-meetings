class Feature < ActiveRecord::Base
  validate :uses_only_permitted_features
  validates :code, uniqueness: true
  validates :name, uniqueness: true

  def uses_only_permitted_features
    if !Feature.permitted_features.keys.include?(code)
      errors.add(:code,
        "Must use code from #{Feature.permitted_features.keys}")
    elsif !Feature.permitted_features.values.include?(name)
      errors.add(:name,
        "Must use feature name from #{Feature.permitted_features.values}")
    end
  end

  def self.get_asl
    self.find_or_create_by(code: "ASL") do |feature|
      feature.name = "Sign Language Interpreter"
    end
  end

  def self.get_accessible
    self.find_or_create_by(code: "*") do |feature|
      feature.name = "Accessible"
    end
  end

  def self.get_non_smoking
    self.find_or_create_by(code: "n") do |feature|
      feature.name = "Non-Smoking"
    end
  end

  def self.get_sitter
    self.find_or_create_by(code: "Sit") do |feature|
      feature.name = "Sitter"
    end
  end

  def self.match_asl(codes)
    codes =~ /.*ASL.*/
  end

  def self.match_accessible(codes)
    codes =~ /.*\*.*/
  end

  def self.match_non_smoking(codes)
    codes =~ /(^n.*)|.*[^pr]n.*/
  end

  def self.match_sitter(codes)
    codes =~ /.*Sit.*/
  end

  def self.get_features(codes)
    features = []
    features << get_asl if match_asl(codes)
    features << get_accessible if match_accessible(codes)
    features << get_non_smoking if match_non_smoking(codes)
    features << get_sitter if match_sitter(codes)
    features
  end

  def self.permitted_features
    {"ASL" => "Sign Language Interpreter",
      "*" => "Accessible",
      "n" => "Non-Smoking",
    "Sit" => "Sitter"}
  end
end
