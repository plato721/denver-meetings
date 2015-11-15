module Mobile::SearchHelper
  def distance_display?(divider)
    divider.include?("mile")
  end
end
