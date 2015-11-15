module Mobile::SearchHelper
  def distance_display?(divider)
    divider.include?("mile")
  end

  def meeting_with_distance(meeting)
    "#{meeting.day}, #{meeting.time}, #{pluralize(meeting.distance, "mile")}"

  end

  def meeting_without_distance(meeting)
    "#{meeting.day}, #{meeting.time}"
  end
end
