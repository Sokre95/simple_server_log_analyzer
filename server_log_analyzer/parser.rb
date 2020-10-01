require_relative './line_parser.rb'

module ServerLogAnalyzer
  class LogParser
    attr_reader :storage

    def initialize(file_path:, storage:, line_matcher:)
      @log_file = File.new(file_path)
      @log_file.advise(:sequential)
      
      @storage = storage
      @line_parser = LineParser.new(line_matcher)
    end

    def parse
      @log_file.each{ |line| @storage << @line_parser.parse(line) }
    end
  end
end