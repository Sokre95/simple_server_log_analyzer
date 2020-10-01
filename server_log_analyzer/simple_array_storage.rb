require_relative './storage.rb'

module ServerLogAnalyzer
  class SimpleArrayStorage < LogStorage
    def initialize
      @storage = [] 
    end

    def <<(entry)
      @storage << entry
    end

    def each(&block)
      @storage.each(&block)
    end
  end
end