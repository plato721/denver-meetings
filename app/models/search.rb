class Search < ActiveRecord::Base
  def self.create_search(params)
    self.create({free: params["free_search"],
              city: params["city"],
              group_name: params["name"],
              day: params["day"],
              time: params["time"],
              open: params["open"]})
  end

  def results
    by_name = Meeting.by_group("%#{self.group_name}%")

  end
end