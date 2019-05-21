require 'byebug'

require 'yaml'
require 'erb'
require_relative '../serializers/bigfive_results_text_serializer'
require_relative '../services/big_five_results_poster'
require_relative '../helpers/parse_config'

config = Helpers::ParseConfig.config

result_content = File.open(File.expand_path('./test_result.txt')).read

parsed_data = BigFiveResultsTextSerializer.new(result_content)

data = parsed_data.to_h

byebug
request = BigFiveResultsPoster.new(data, config["post"]["email"])

