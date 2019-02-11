class MeetingCreator::Address1Extractor
  def self.extract(raw_meeting)
    address = raw_meeting.address
    address = check_and_fix_clarkson(address)
    address = check_and_fix_wadsworth(address)
    address = keep_only_before_pound(address)
    address = keep_only_before_notes(address)
    address = keep_only_before_comma(address)
  end

  # clarkson is a street and needs to be that way to be geocoded, but is
  # missing the suffix on daccaa.
  def self.check_and_fix_clarkson(address)
    return address unless address.match(/Clarkson/) &&
      !address.match(/Clarkson St/)
    address.gsub(/Clarkson/, 'Clarkson St.')
  end

  def self.check_and_fix_wadsworth(address)
    return address unless address.match(/Wadsworth/) &&
      !address.match(/Wadsworth Blvd/)

    address.gsub(/Wadsworth/, 'Wadsworth Blvd.')
  end

  def self.keep_only_before_pound(address)
    matched = address.match(/#/)
    return address unless matched

    matched.pre_match.strip
  end

  def self.keep_only_before_notes(address)
    matched = address.match(/\(.+\)/)
    return address unless matched

    matched.pre_match.strip
  end

  def self.keep_only_before_comma(address)
    matched = address.match(/,/)
    return address unless matched

    matched.pre_match.strip
  end
end