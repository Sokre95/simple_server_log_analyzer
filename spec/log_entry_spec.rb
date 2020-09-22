require_relative "spec_helper"
require_relative "../server_log_analyzer/log_entry"

RSpec.describe ServerLogAnalyzer::LogEntry do
  let(:entry) { ServerLogAnalyzer::LogEntry.new("127.0.0.1", "/smth/1") }

  it 'responds to endpoint and ip calls' do
    expect(entry).to respond_to(:ip_address)
    expect(entry).to respond_to(:endpoint)
  end

  it 'returns assigned ip and endpoint' do
    expect(entry.ip_address).to eq("127.0.0.1")
    expect(entry.endpoint).to eq("/smth/1")
  end
end