require 'database_cleaner'
require 'simplecov'
require 'webmock'

RSpec.configure do |config|
  config.backtrace_exclusion_patterns = []
  config.backtrace_exclusion_patterns << /.*\/gems\/.*/

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do
    DatabaseCleaner.start
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    Rails.application.load_seed
  end

  config.after(:suite) do
    DatabaseCleaner.clean
  end

  WebMock.stub_request(:any, "www.localhost:3000")
  WebMock.stub_request(:get, "http://maps.googleapis.com/maps/api/geocode/json?address=3355%20S.%20Wadsworth%20Ave.,%20Lakewood,%20CO&language=en&sensor=false")
  WebMock.stub_request(:get, "http://maps.googleapis.com/maps/api/geocode/json?address=3355%20S.%20Wadsworth%20Bl.%20%23H-127,%20Lakewood,%20CO&language=en&sensor=false")

  def login(user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  def no_geocoding
    allow_any_instance_of(Address).to receive(:geocode).and_return(nil)
    geocoder_result = double(:result, data: {
      "place_id" => 240016995,
      "licence" => "Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright",
      "osm_type" => "way",
      "osm_id" => 628364649,
      "lat" => "39.8418828993539",
      "lon" => "-105.081345000655",
      "display_name" => "West 80th Avenue, Arvada, Jefferson County, Colorado, 80003, USA",
      "address" =>
        {"road" => "West 80th Avenue",
        "town" => "Arvada",
        "county" => "Jefferson County",
        "state" => "Colorado",
        "postcode" => "80003",
        "country" => "USA",
        "country_code" => "us"},
      "boundingbox" => ["39.8418784", "39.8418829", "-105.0813451", "-105.0806532"]}
 )
    geocoder_results = [geocoder_result]
    allow(Geocoder).to receive(:search).and_return(geocoder_results)
  end

=begin
  # These two settings work together to allow you to limit a spec run
  # to individual examples or groups you care about by tagging them with
  # `:focus` metadata. When nothing is tagged with `:focus`, all examples
  # get run.
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  # Allows RSpec to persist some state between runs in order to support
  # the `--only-failures` and `--next-failure` CLI options. We recommend
  # you configure your source control system to ignore this file.
  config.example_status_persistence_file_path = "spec/examples.txt"

  # Limits the available syntax to the non-monkey patched syntax that is
  # recommended. For more details, see:
  #   - http://myronmars.to/n/dev-blog/2012/06/rspecs-new-expectation-syntax
  #   - http://www.teaisaweso.me/blog/2013/05/27/rspecs-new-message-expectation-syntax/
  #   - http://myronmars.to/n/dev-blog/2014/05/notable-changes-in-rspec-3#new__config_option_to_disable_rspeccore_monkey_patching
  config.disable_monkey_patching!

  # Many RSpec users commonly either run the entire suite or an individual
  # file, and it's useful to allow more verbose output when running an
  # individual spec file.
  if config.files_to_run.one?
    # Use the documentation formatter for detailed output,
    # unless a formatter has already been configured
    # (e.g. via a command-line flag).
    config.default_formatter = 'doc'
  end

  # Print the 10 slowest examples and example groups at the
  # end of the spec run, to help surface which specs are running
  # particularly slow.
  config.profile_examples = 10

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = :random

  # Seed global randomization in this process using the `--seed` CLI option.
  # Setting this allows you to use `--seed` to deterministically reproduce
  # test failures related to randomization by passing the same `--seed` value
  # as the one that triggered the failure.
  Kernel.srand config.seed
=end
end
