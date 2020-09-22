require_relative './log_entry'

module ServerLogAnalyzer
  class LogParser

    def initialize(file_path)
      @log_file = File.open(file_path)
    end

    def parse
      @log_file.readlines.map{ |line| parse_single_line(line) }
    end

    private

      def parse_single_line(line)
        endpoint, ip = line.strip.split(' ')
        LogEntry.new(ip, endpoint)
      end
  end
end