module ServerLogAnalyzer
  class LogStorage
    include Enumerable

    def <<
      raise NotImplementedException
    end
  end
end