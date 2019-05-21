# frozen_string_literal: true

module Helpers
  # Helper class to parse a given large text
  class Parser
    attr_accessor :scores

    USERNAME_REGEX = /compares\s(.+?)\sfrom/.freeze
    SCORE_TABLES_REGEX = /(^\w.*[.....])(\d{1,2})/.freeze

    def initialize(text = '')
      @text = text
    end

    # Given a text looks for the user's name
    def extract_user_name
      name = @text.scan(USERNAME_REGEX)
      return name.first.first.strip unless name.empty?

      ''
    end

    # Given a text with score results
    # Extracts the score's tables
    def extract_scores
      @scores = @text.scan(SCORE_TABLES_REGEX)
      @scores.each do |el|
        { el.first.delete!('.') => el.last }
      end
    end
  end
end
