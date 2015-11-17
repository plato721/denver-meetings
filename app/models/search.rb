class Search < ActiveRecord::Base
  def self.create_search(params)
    self.create({free: params["free_search"],
              city: params["city"],
              group_name: params["name"],
              day: params["day"],
              time: params["time"],
              open: params["open"],
              lat: params["lat"],
              lng: params["lng"],
              here_and_now: params["here_and_now"],
              city_text: params["city_text"],
              group_text: params["group_text"],
              open: params["open"],
              men: params["men"],
              women: params["women"],
              youth: params["youth"],
              gay: params["gay"],
              access: params["access"],
              non_smoking: params["n"],
              sitter: params["sitter"],
              spanish: params["spanish"],
              polish: params["polish"],
              french: params["french"]
              })
  end

  def self.set_defaults(params)
    params.merge(defaults)
  end

  def self.defaults
    {lat: nil,
    lng: nil,
    here_and_now: false}
  end

  def results
    return HereAndNow.new(self.to_h).search if self.here_and_now
    raw_meetings = Meeting.search(self.to_h)
    MobileListDisplay.new(raw_meetings)
  end

  def to_h
    Search.column_names.map(&:to_sym).map do |column|
      [column, self.send(column)]
    end.to_h
  end

  def remove_empty_params
    all = search_to_params_values
  end

  def search_to_params_values
    Search.columns.map do |param|
      [param, self.send(param.to_sym)]
    end
  end
end