class Day
  attr_reader :day

  def initialize(day)
    @day = day
  end

  def day_order
    ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
  end

  def to_s
    "#{self.day}"
  end

  def <=>(other)
    day_order.index(self.day) <=> day_order.index(other.day)
  end
end