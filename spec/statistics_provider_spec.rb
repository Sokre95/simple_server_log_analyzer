require_relative "spec_helper"
require_relative "../server_log_analyzer/log_parser"
require_relative "../server_log_analyzer/statistics_provider"

RSpec.describe ServerLogAnalyzer::StatisticsProvider do
  let(:log_parser) { ServerLogAnalyzer::LogParser.new("./spec/../webserver.log") }
  let(:stat_provider) { ServerLogAnalyzer::StatisticsProvider.new(log_parser.parse) }

  describe "#new" do
    it "initializes statistics data structures" do
      expect(stat_provider.endpoints_statistics.class).to eq(Hash)
      expect(stat_provider.visitors_statistics.class).to eq(Hash)

      expect(stat_provider.endpoints_statistics["/contact"][:visitors].class).to eq(Array)
      expect(stat_provider.visitors_statistics["646.865.545.408"][:pages_visited].class).to eq(Array)

      expect(stat_provider.endpoints_statistics.first[1].keys).to eq([:total_visits, :unique_visits, :visitors])
      expect(stat_provider.visitors_statistics.first[1].keys).to eq([:total_visits, :pages_visited])
    end

    it "collects data from log entries" do
      expect(stat_provider.endpoints_statistics["/contact"][:visitors].uniq.count).to eq(23)
      expect(stat_provider.visitors_statistics["646.865.545.408"][:pages_visited].uniq.count).to eq(6)
    end
  end

  describe "#calculate_endpoints_statistics" do
    subject { stat_provider.calculate_endpoints_statistics }

    it "calculates total visits, unique visits and visitors for all endpoints" do
      expect{subject}.to change{ stat_provider.endpoints_statistics["/contact"][:total_visits] }.from(0).to(89)
        .and change{ stat_provider.endpoints_statistics["/contact"][:unique_visits] }.from(0).to(23)
        .and change{ stat_provider.endpoints_statistics["/contact"][:visitors] }.to(
          ["184.123.665.067",
           "543.910.244.929",
           "555.576.836.194",
           "200.017.277.774",
           "316.433.849.805",
           "836.973.694.403",
           "158.577.775.616",
           "016.464.657.359",
           "682.704.613.213",
           "444.701.448.104",
           "802.683.925.780",
           "382.335.626.855",
           "722.247.931.582",
           "126.318.035.038",
           "336.284.013.698",
           "451.106.204.921",
           "897.280.786.156",
           "217.511.476.080",
           "061.945.150.735",
           "646.865.545.408",
           "235.313.352.950",
           "715.156.286.412",
           "929.398.951.889"]
        )
    end
  end

  describe "#calculate_visitors_statistics" do
    subject { stat_provider.calculate_visitors_statistics }

    it "calculates total visits and pages_visited for all visitors" do
      expect{subject}.to change{ stat_provider.visitors_statistics["126.318.035.038"][:total_visits] }.from(0).to(18)
        .and change{ stat_provider.visitors_statistics["126.318.035.038"][:pages_visited] }.to(
          ["/help_page/1", "/about", "/about/2", "/contact", "/index", "/home"]
        )
    end
  end

  describe "#unique_endpoints" do
    it 'returns array with unique endpoints' do
      expect(stat_provider.unique_endpoints).to eq(
        ["/help_page/1", "/contact", "/home", "/about/2", "/index", "/about"]
      )
    end
  end

  describe "#unique_visitors" do
    it 'returns array with unique visitors' do
      expect(stat_provider.unique_visitors).to eq(
        ["126.318.035.038",
         "184.123.665.067",
         "444.701.448.104",
         "929.398.951.889",
         "722.247.931.582",
         "061.945.150.735",
         "646.865.545.408",
         "235.313.352.950",
         "543.910.244.929",
         "316.433.849.805",
         "836.973.694.403",
         "802.683.925.780",
         "555.576.836.194",
         "200.017.277.774",
         "382.335.626.855",
         "336.284.013.698",
         "715.156.286.412",
         "451.106.204.921",
         "158.577.775.616",
         "897.280.786.156",
         "016.464.657.359",
         "682.704.613.213",
         "217.511.476.080"]
      )
    end
  end
end