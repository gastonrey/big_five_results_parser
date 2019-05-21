# frozen_string_literal: true

require 'typhoeus'
require 'json'
require_relative '../helpers/parse_config'

# Instead of creating my own Dry::Struct and Result
# I decided to use Typhoeus which already returns this type of object
class BigFiveResultsPoster
  def initialize(results_hash, email)
    raise 'Email required' unless email

    @results_hash = results_hash.merge('EMAIL' => email)
    @url = Helpers::ParseConfig.config['post']['url']
  end

  # Returned object responds to next methods:
  #   #success?: Boolean
  #   #response_code: Integer
  #   #body: String
  def post
    Typhoeus.post(@url,
                  body: @results_hash.to_json,
                  headers: { 'Content-Type' => 'application/json' })
  end
end
