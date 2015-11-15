class Day
  attr_reader :day

  def initialize(day)
    @day = day
  end

  def self.display_today
    int_to_day[TimeConverter.now_raw.wday]
  end

  def self.display_tomorrow
    int_to_day[(TimeConverter.now_raw.wday + 1) % 7]
  end

  def self.day_order
    ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
  end

  def self.day_to_int
    day_order.zip([*0..6]).to_h
  end

  def self.int_to_day
    [*0..6].zip(day_order).to_h
  end

  def to_s
    "#{self.day}"
  end

  def <=>(other)
    Day.day_order.index(self.day) <=> Day.day_order.index(other.day)
  end
end