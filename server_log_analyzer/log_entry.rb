module ServerLogAnalyzer
  class LogEntry
    attr_reader :ip_address, :endpoint

    def initialize(ip, endpoint)
      @ip_address = ip
      @endpoint = endpoint
    end
  end
end