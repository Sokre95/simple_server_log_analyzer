class CommandLinePresenter
  def initialize(stats)
    @stats = stats
  end

  def print
    puts "\n#{"*" * 30} Endpoints #{"*" * 30}"
    puts "All endpoints: #{@stats[:endpoints][:value].join(", ")}"

    puts "\nOrdered descending by total visists:"
    @stats[:per_endpoint].each.sort_by{ |k,v| v[:total_visits]}.reverse.each do |endpoint, endpoint_stat|
      puts "#{endpoint.ljust(20)} -> total: #{endpoint_stat[:total_visits]}, unique: #{endpoint_stat[:unique_visits]}"
    end
    puts "\nOrdered descending by unique visists:"
    @stats[:per_endpoint].each.sort_by{ |k,v| v[:unique_visits]}.reverse.each do |endpoint, endpoint_stat|
      puts "#{endpoint.ljust(20)} -> total: #{endpoint_stat[:total_visits]}, unique: #{endpoint_stat[:unique_visits]}"
    end

    puts "\n#{"*" * 30} Visitors #{"*" * 30}"
    puts "All visitors: #{@stats[:visitors][:value].join(", ")}"

    puts "\nOrdered descending by total visists:"
    @stats[:per_visitor].sort_by{ |k,v| v[:visits]}.reverse.each do |visitor, visitor_stat|
      puts "#{visitor.ljust(20)} -> total: #{visitor_stat[:visits]}, unique:#{visitor_stat[:pages_visited].count}, pages visited: #{visitor_stat[:pages_visited]}"
    end

    puts "\n#{"*" * 200}"
  end
end