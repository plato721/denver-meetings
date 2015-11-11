class SearchRequest < ActiveRecord::Base
  def self.create_request(params)
    self.create({text: params["free_search"],
              city: params["city"],
              name: params["name"],
              time: params["time"],
              open: params["open"]})
  end
end