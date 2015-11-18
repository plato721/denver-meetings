RSpec.shared_context "search" do
  def default_params
    {time: "any",
    day: "any",
    group_name: "any",
    open: "any",
    men: "show",
    women: "show",
    youth: "show",
    gay: "show",
    access: "show",
    non_smoking: "show",
    sitter: "show",
    spanish: "show",
    polish: "show",
    french: "show"}
  end
end