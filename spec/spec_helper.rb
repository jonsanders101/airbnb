ENV['RACK_ENV'] ||= 'test'

require "simplecov"
require "simplecov-console"
require "capybara/rspec"

require 'data_mapper'
require 'database_cleaner'
require "./app/app.rb"
require "web_helper"
require_relative '../app/models/user'

Capybara.app = MakersBnb

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before(:suite) do
    include DataMapperSetup
    data_mapper_setup

    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
])
SimpleCov.start
