require 'bundler/setup'
require 'activerecord_upsert'
require 'database_cleaner'

RSpec.configure do |config|
  config.expect_with(:rspec) do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with(:rspec) do |mocks|
    mocks.verify_partial_doubles = true
    mocks.yield_receiver_to_any_instance_implementation_blocks = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching(:focus)
  config.example_status_persistence_file_path = '.rspec_status'
  config.disable_monkey_patching!

  config.order = :random
  Kernel.srand(config.seed)

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before do
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end
end

require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'mysql2',
  database: 'active_record_upsert_test',
  username: ENV['MYSQL_USERNAME'],
  password: ENV['MYSQL_PASSWORD']
)

load File.dirname(__FILE__) + '/support/schema.rb'
require File.dirname(__FILE__) + '/support/models.rb'

# ActiveRecord::Base.logger = Logger.new(STDOUT)
