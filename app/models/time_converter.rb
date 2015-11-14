class TimeConverter
  def self.to_dec(raw)
    return raw if !raw.is_a? String
    converted = base_convert(raw)
    no_merid = remove_meridian(raw)
    hours = hour(no_merid)
    fraction = hour_fraction(no_merid)
    converted + hours + fraction
  end

  def self.now
    hour = Time.now.strftime("%H").to_i
    min = Time.now.strftime("%M").to_f / 60
    hour + min
  end

  def self.hour(raw)
    colon = raw.match(/:/)
    colon.pre_match.to_f
  end

  def self.hour_fraction(raw)
    colon = raw.match(/:/)
    minutes = colon.post_match.to_f
    minutes / 60
  end

  def self.remove_meridian(raw)
    raw.gsub(/AM/, "").gsub(/ /, "")
  end

  def self.base_convert(raw)
    if am?(raw) || raw.match(/:/).pre_match == "12"
      0.0
    else
      12.0
    end
  end

  def self.am?(raw)
    raw.include?("AM")
  end

  def self.display(raw)
    am_pm = display_meridian(raw)
    hours = display_hours(raw)
    mins = display_minutes(raw)
    hours + ":" + mins + am_pm
  end

  def self.display_meridian(raw)
    display_am?(raw) ? "am" : "pm"
  end

  def self.display_minutes(raw)
    no_hours = raw - raw.floor
    (no_hours * 60).round(0).to_i.to_s.rjust(2, "0")
  end

  def self.display_hours(raw)
    raw = raw - 12 if raw.floor >= 13
    raw.floor.to_s
  end

  def self.display_am?(raw)
    raw < 12
  end

end
