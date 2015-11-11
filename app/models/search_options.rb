class SearchOptions
  def initialize
  end

  def cities
    @cities ||= Meeting.pluck
  end


end