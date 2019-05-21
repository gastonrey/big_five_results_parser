# frozen_string_literal: true

require 'byebug'
require 'json'
require_relative '../serializers/bigfive_results_text_serializer'
require_relative '../services/big_five_results_poster'

RSpec.configure do |conf|
  conf.mock_with :rspec do |mocks|
    mocks.verify_doubled_constant_names = true
  end

  conf.after :suite do
    puts ''
    rubocop_command = 'bundle exec rubocop'
    raise 'RuboCop Errors' unless system rubocop_command
  end
end
