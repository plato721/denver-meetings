class SearchByAccess
  def initialize(params)

  end

  def search(params)

  end

  def all
    Meeting.all
  end

  def sitter(sitter)
    return all if sitter == "show"
    if sitter == "only"
      includes(:features).where(features: { name: "Sitter" })
    elsif sitter == "hide"
      includes(:features).where(features: { name: ["Accessible", "Non-Smoking", "Sign Language Interpreter", nil] })
    end
  end

  def access(access)
    return all if access == "show"
    if access == "only"
      includes(:features).where(features: { name: "Accessible" })
    elsif access == "hide"
      includes(:features)
      .where(features: { name: ["Sitter", "Non-Smoking", "Sign Language Interpreter", nil] })
    end
  end

  def non_smoking(non_smoking)
    return all if non_smoking == "show"
    if non_smoking == "only"
      includes(:features).where(features: { name: "Non-Smoking" })
    elsif non_smoking == "hide"
      includes(:features).where(features: { name: ["Sitter", "Accessible", "Sign Language Interpreter", nil] })
    end
  end
end