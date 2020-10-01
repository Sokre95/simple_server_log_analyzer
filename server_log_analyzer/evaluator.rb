module ServerLogAnalyzer
  class Evaluator

    def initialize(storage:)      
      @storage = storage
    end

    def evaluate(proc = nil, &block)
      return proc.call(@storage) if proc
      return block.call(@storage) if block
    end
  end
end
