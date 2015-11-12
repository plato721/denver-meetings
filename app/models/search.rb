class Search < ActiveRecord::Base
  def self.create_search(params)
    self.create({free: params["free_search"],
              city: params["city"],
              group_name: params["name"],
              day: params["day"],
              time: params["time"],
              open: params["open"]})
  end
end