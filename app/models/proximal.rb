class Proximal
  attr_reader :lat, :lng

  def initialize(meeting)
    @lat = meeting.address&.lat
    @lng = meeting.address&.lng
  end

  def earth_radius #in miles, at 39.xx degrees latitude
    3961
  end

  def to_rad(degrees)
    (Math::PI * degrees) / 180
  end

  def self.nearest(num_meetings, coords)
    meetings_with_distance(coords).take(num_meetings)
  end

  def self.meetings_with_distance(coords)
    Meeting.all.map do |meeting|
      [meeting, Proximal.new(meeting).distance_from(coords)]
    end.to_h.sort_by {|_, distance| distance}
  end

  # My thanks to Chris Veness for the javascript implementation of this equation
  # found on http://www.movable-type.co.uk/scripts/latlong.html
  def distance_from(coords)
    lat_1_rads = to_rad(self.lat)
    lat_2_rads = to_rad(coords.first)

    lat_delta_rads = to_rad(self.lat - coords.first)
    lng_delta_rads = to_rad(self.lng - coords.last)

    # "a" and "c" monikers are from the Haversine formula. the return
    # result would be called "d" in this formula
    a = Math.sin(lat_delta_rads / 2) * Math.sin(lat_delta_rads / 2) +
            Math.cos(lat_1_rads) * Math.cos(lat_2_rads) *
            Math.sin(lng_delta_rads/2) * Math.sin(lng_delta_rads/2)
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))

    earth_radius * c
  end
end
