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

  def meeting_count(meeting_group)
    meeting_group.inject(0) do |acc, meeting_group|
        acc + meeting_group.last.length
    end
  end
end
