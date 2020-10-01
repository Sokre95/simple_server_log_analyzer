require_relative './parser'
require_relative './evaluator'

module ServerLogAnalyzer
  class Analyzer

    def initialize(storage:, file_path:, line_matcher:)
      @storage = storage
      @parser = ServerLogAnalyzer::LogParser.new(
        file_path: file_path,
        line_matcher: line_matcher,
        storage: @storage
      )
      @evaluator = ServerLogAnalyzer::Evaluator.new(storage: @storage)
      @expressions = []
    end

    def add_expression(proc)
      @expressions << proc
      self
    end

    def run
      @parser.parse
      @expressions.each do |expr|
        @evaluator.evaluate(expr)
      end
    end
  end
end