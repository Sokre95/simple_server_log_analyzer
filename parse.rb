require_relative './server_log_analyzer/simple_array_storage'
require_relative './server_log_analyzer/analyzer'
require_relative './user_analysis'
require_relative './cli_presenter'
require 'optparse'

options = { log_file: "webserver.log" }

OptionParser.new do |opts|
  opts.banner = "Usage: ruby print_sotred_statistics_example.rb [options]"
  opts.on("-fNAME", "--logFile=NAME", "Log file to analyze(default: 'webserver.log')") { |v| options[:log_file] = v.to_s }
end.parse!

# Provide regex that matches the log file format 
analyzer = ServerLogAnalyzer::Analyzer.new(
  file_path: options[:log_file],
  line_matcher: /(?<endpoint>\/(?:\w|\/)*)\s(?<ip>(?:\d{3}.?){4})?(?<rest>.*)*/, # this can also be cli params
  storage: ServerLogAnalyzer::SimpleArrayStorage.new,
)

# USER defines how the results will be calculated and stored
stats = {
  endpoints: {},
  visitors: {},
  per_endpoint: {},
  per_visitor: {}
}

analysis = UserAnalysis.new(stats)

analyzer.add_expression(analysis.get_endpoints)
  .add_expression(analysis.get_visitors)
  .add_expression(analysis.get_stat_per_visitor)
  .add_expression(analysis.get_stat_per_endpoint)

analyzer.run

CommandLinePresenter.new(stats).print