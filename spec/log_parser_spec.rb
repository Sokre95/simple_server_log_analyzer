require_relative "spec_helper"
require_relative "../server_log_analyzer/parser"
require_relative "../server_log_analyzer/simple_array_storage"


RSpec.describe ServerLogAnalyzer::LogParser do
  let(:storage){ ServerLogAnalyzer::SimpleArrayStorage.new }
  let(:log_parser) do 
    ServerLogAnalyzer::LogParser.new(
      file_path: "./spec/../webserver.log",
      storage: storage, 
      line_matcher: /(?<endpoint>\/(?:\w|\/)*)\s(?<ip>(?:\d{1,3}.?){4})?(?<rest>.*)*/
    )
  end

  describe "#parse" do
    it "parses log file properly" do 
      log_parser.parse
      
      expect(storage.first[:endpoint]).to eq("/help_page/1")
      expect(storage.first[:ip]).to eq("126.318.035.038")
    end
  end
end