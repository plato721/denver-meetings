module ApplicationHelper
  def cache_key_for(model_class, label = "")
    prefix = model_class.to_s.downcase.pluralize
    count = model_class.count
    last_updated = model_class.maximum(:updated_at)

    [prefix, label, count, last_updated].join("-")
  end
end
