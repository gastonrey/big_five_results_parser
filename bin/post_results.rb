# frozen_string_literal: true

require 'yaml'
require 'erb'
require_relative '../serializers/bigfive_results_text_serializer'
require_relative '../services/big_five_results_poster'
require_relative '../helpers/parse_config'

config = Helpers::ParseConfig.config
result_content = File.open(File.expand_path('./test_result.txt')).read
parsed_data = BigFiveResultsTextSerializer.new(result_content)

request = BigFiveResultsPoster.new(parsed_data.to_h, config['post']['email'])
res = request.post

puts "Result has been: \n"
puts "\tResponse code: #{res.response_code}"

if res.success?
  puts "\tToken: #{res.body}"
else
  puts "\tErrors: #{res.body}"
end
