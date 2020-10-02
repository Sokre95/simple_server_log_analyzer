require_relative "spec_helper"
require_relative "../server_log_analyzer/parser"
require_relative "../server_log_analyzer/simple_array_storage"


RSpec.describe ServerLogAnalyzer::LineParser do
  let(:line_parser) do 
    ServerLogAnalyzer::LineParser.new(/(?<endpoint>\/(?:\w|\/)*)\s(?<ip>(?:\d{1,3}.?){4})?(?<rest>.*)*/)
  end

  describe "#parse" do
    context "when expected line with an ip and endpoint is provided" do
      it "parses ip and endpoint properly" do
        parsed = line_parser.parse("/nested/route/12 127.0.0.1")

        expect(parsed[:ip]).to eq("127.0.0.1")
        expect(parsed[:endpoint]).to eq("/nested/route/12")
      end
    end
  end
end