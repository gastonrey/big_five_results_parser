# frozen_string_literal: true

require 'yaml'
require 'erb'

module Helpers
  module ParseConfig
    def self.config
      @config ||= begin
                    raw_yaml = File.open('./config/post_parameters.yml').read
                    content = ERB.new(raw_yaml).result
                    YAML.safe_load(content)
                  end
    end
  end
end
