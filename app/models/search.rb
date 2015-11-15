class Search < ActiveRecord::Base
  def self.create_search(params)
    self.create({free: params["free_search"],
              city: params["city"],
              group_name: params["name"],
              day: params["day"],
              time: params["time"],
              open: params["open"]})
  end

  def self.set_defaults(params)
    params.merge(defaults)
  end

  def self.defaults
    {lat: nil,
    lng: nil}
  end

  def results
    # if 
    Meeting.search(self.to_h)
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