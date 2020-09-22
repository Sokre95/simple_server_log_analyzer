module ServerLogAnalyzer
  class StatisticsProvider
    attr_reader :endpoints_statistics
    attr_reader :visitors_statistics

    def initialize(log_entries)
      @log_entries = log_entries

      init_structures
      collect_data
    end

    def calculate_endpoints_statistics
      @unique_endpoints.each do |endpoint|
        @endpoints_statistics[endpoint] = { 
          total_visits: @endpoints_statistics[endpoint][:visitors].count,
          unique_visits: @endpoints_statistics[endpoint][:visitors].uniq.count,
          visitors: @endpoints_statistics[endpoint][:visitors].uniq
        }
      end
    end

    def calculate_visitors_statistics
      @unique_visitors.each do |visitor|
        @visitors_statistics[visitor] = {
          total_visits: @visitors_statistics[visitor][:pages_visited].count,
          pages_visited: @visitors_statistics[visitor][:pages_visited].uniq
        }
      end
    end

    def unique_endpoints
      @unique_endpoints ||= @log_entries.map(&:endpoint).uniq
    end

    def unique_visitors
      @unique_visitors ||= @log_entries.map(&:ip_address).uniq
    end

    private

      def collect_data
        @log_entries.each do |log_entry|
          @endpoints_statistics[log_entry.endpoint][:visitors] << log_entry.ip_address
          @visitors_statistics[log_entry.ip_address][:pages_visited] << log_entry.endpoint
        end
      end

      def init_structures
        @endpoints_statistics = unique_endpoints.map do |endpoint| 
          [endpoint, { total_visits: 0, unique_visits: 0, visitors: [] }]
        end.to_h

        @visitors_statistics = unique_visitors.map do |visitor|
          [visitor, { total_visits: 0, pages_visited: [] }]
        end.to_h
      end
  end
end