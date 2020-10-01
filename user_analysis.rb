class UserAnalysis
  attr_reader :stats

  def initialize(stats)
    @stats = stats
  end

  def get_endpoints
    lambda { |data| stats[:endpoints][:value] = data.map{ |e| e[:endpoint] }.uniq }
  end

  def get_visitors
    lambda { |data| stats[:visitors][:value] = data.map{ |e| e[:ip] }.uniq }
  end

  def get_stat_per_endpoint
    lambda do |data|
      stats[:endpoints][:value].each do |endpoint| 
        visitors = data.filter{ |e| e[:endpoint] == endpoint }.map{ |e| e[:ip] }
        stats[:per_endpoint][endpoint] = {
          visitors: visitors.uniq,
          total_visits: visitors.count,
          unique_visits: visitors.uniq.count
        }
      end
    end
  end

  def get_stat_per_visitor
    lambda do |data|
      stats[:visitors][:value].each do |ip| 
        pages = data.filter{ |e| e[:ip] == ip }.map{ |e| e[:endpoint] }
        stats[:per_visitor][ip] = {
          pages_visited: pages.uniq,
          visits: pages.count
        }
      end
    end
  end
end