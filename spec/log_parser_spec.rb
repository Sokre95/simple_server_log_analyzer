require_relative "spec_helper"
require_relative "../server_log_analyzer/log_parser"

RSpec.describe ServerLogAnalyzer::LogParser do
  let(:log_parser) { ServerLogAnalyzer::LogParser.new("./spec/../webserver.log") }

  describe "#parse" do
    it "returns array of log entries" do
      entries = log_parser.parse

      expect(entries.class).to eq(Array)
      expect(entries.first.class).to eq(ServerLogAnalyzer::LogEntry)
    end

    it "returns log entries properly parsed" do 
      first_entry = log_parser.parse.first
      
      expect(first_entry.endpoint).to eq("/help_page/1")
      expect(first_entry.ip_address).to eq("126.318.035.038")
    end
  end
end