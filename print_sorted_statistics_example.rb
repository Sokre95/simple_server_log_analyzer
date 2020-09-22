require_relative './server_log_analyzer/log_parser'
require_relative './server_log_analyzer/statistics_provider'

parsed_entries = ServerLogAnalyzer::LogParser.new("webserver.log").parse
statistics_provider = ServerLogAnalyzer::StatisticsProvider.new(parsed_entries)

statistics_provider.calculate_endpoints_statistics
statistics_provider.calculate_visitors_statistics

puts "\n#{"*" * 30} Endpoints #{"*" * 30}"
puts "All endpoints: #{statistics_provider.unique_endpoints.join(", ")}"

puts "\nOrdered descending by total visists:"
statistics_provider.endpoints_statistics.sort_by{ |k,v| v[:unique_visits]}.reverse.each do |endpoint, endpoint_stat|
  puts "#{endpoint.ljust(20)} -> total: #{endpoint_stat[:total_visits]}, unique: #{endpoint_stat[:unique_visits]}"
end
puts "\nOrdered descending by unique visists:"
statistics_provider.endpoints_statistics.sort_by{ |k,v| v[:unique_visits]}.reverse.each do |endpoint, endpoint_stat|
  puts "#{endpoint.ljust(20)} -> total: #{endpoint_stat[:total_visits]}, unique: #{endpoint_stat[:unique_visits]}"
end

puts "\n#{"*" * 30} Visitors #{"*" * 30}"
puts "All visitors: #{statistics_provider.unique_visitors.join(", ")}"

puts "\nOrdered descending by total visists:"
statistics_provider.visitors_statistics.sort_by{ |k,v| v[:total_visits]}.reverse.each do |visitor, visitor_stat|
  puts "#{visitor.ljust(20)} -> total: #{visitor_stat[:total_visits]}, unique:#{visitor_stat[:pages_visited].count}, pages visited: #{visitor_stat[:pages_visited]}"
end
