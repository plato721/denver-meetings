class Day
  attr_reader :day

  def initialize(day)
    @day = day
  end

  def to_s
    "#{self.day}"
  end
end