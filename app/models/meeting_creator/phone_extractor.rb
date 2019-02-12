class MeetingCreator::PhoneExtractor
  def self.extract(raw_meeting)
    matched = raw_meeting.address.match(phone_matcher)
    matched ? matched.to_s : ''
  end

  def self.phone_matcher
    /\d{3}(-\d{3})?-\d{4}/
  end
end
