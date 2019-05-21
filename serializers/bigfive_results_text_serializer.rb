# frozen_string_literal: true

require_relative '../helpers/parser'

# Serialize a given text by parsing and creating a Hash
class BigFiveResultsTextSerializer
  def initialize(input)
    @input = input
    @parser = Helpers::Parser.new(@input)
    @parser.extract_scores
    @scores = {}
    @maped_list_to_hash = {}
  end

  def to_h
    build_hash

    if @maped_list_to_hash.empty?
      {}
    else
      @maped_list_to_hash.merge!('NAME' => @parser.extract_user_name)
    end
  end

  private

  def build_hash
    elements = @parser.scores.shift
    return unless elements

    if elements.first == elements.first.upcase
      @maped_list_to_hash[elements.first] = { overall_scores: elements.last }
      @maped_list_to_hash[elements.first].merge!(
        facets: pop_until_next_root(@parser.scores)
      )
      @scores = {}
    end

    build_hash
  end

  def pop_until_next_root(list)
    return {} if list.empty?

    unless list.first.first == list.first.first.upcase
      el = list.shift
      @scores[el.first] = el.last
      pop_until_next_root(list)
    end

    @scores
  end
end
