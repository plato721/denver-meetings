class MeetingCreator::Address1Extractor
  def self.extract(raw_meeting, _)
    address = raw_meeting.address

    address = check_and_fix_clarkson(address)
    address = check_and_fix_depew(address)
    address = check_and_fix_iliff(address)
    address = check_and_fix_72nd(address)

    # next two are order dependent
    address = check_and_fix_wadsworth_bl(address)
    address = check_and_fix_wadsworth(address)

    # notes needs to come before unit
    address = keep_only_before_notes(address)
    address = keep_only_before_unit(address)
    address = keep_only_before_comma(address)
    address = keep_only_before_phone(address)
    address.strip
  end

  def self.check_and_fix_wadsworth_bl(address)
    return address unless address.match(/Wadsworth Bl\./)

    address.gsub(/Wadsworth Bl\./, 'Wadsworth Blvd.')
  end

  def self.check_and_fix_depew(address)
    return address unless address.match(/Depew/) &&
      !address.match(/Depew St/)

    address.gsub(/Depew /, 'Depew St. ')
  end

  # TODO - add one to make Av. Ave.
  def self.check_and_fix_iliff(address)
    return address unless address.match(/Iliff/) &&
      !address.match(/Iliff Av/)

    address.gsub(/Iliff /, 'Iliff Ave. ')
  end

  def self.check_and_fix_72nd(address)
    return address unless address.match(/72nd/) &&
      !address.match(/72nd Ave/)

    address.gsub(/72nd /, '72nd Ave. ')
  end

  # clarkson is a street and needs to be that way to be geocoded, but is
  # missing the suffix on daccaa.
  def self.check_and_fix_clarkson(address)
    return address unless address.match(/Clarkson/) &&
      !address.match(/Clarkson St/)
    address.gsub(/Clarkson /, 'Clarkson St. ')
  end

  def self.check_and_fix_wadsworth(address)
    return address unless address.match(/Wadsworth/) &&
      !address.match(/Wadsworth Blvd/)

    address.gsub(/Wadsworth /, 'Wadsworth Blvd. ')
  end

  # any parenthetical notes like '8817 S. Broadway (Ch)'
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

  def self.keep_only_before_unit(address)
    matched = address.match(/(Unit|Ste|#)/)
    return address unless matched

    matched.pre_match.strip
  end

  def self.keep_only_before_phone(address)
    matched = address.match(/\d{3}(-\d{3})?-\d{4}/)
    return address unless matched

    matched.pre_match.strip
  end
end