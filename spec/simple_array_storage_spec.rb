require_relative "spec_helper"
require_relative "../server_log_analyzer/simple_array_storage"


RSpec.describe ServerLogAnalyzer::SimpleArrayStorage do
  let(:storage) { ServerLogAnalyzer::SimpleArrayStorage.new }

  describe "<<" do 
    it "adds new item to storage" do
      expect{storage << "new_item"}.to change{ storage.each.to_a }.from([]).to(["new_item"])
    end
  end


  describe "#each" do
    before do 
      storage << "entry_1" << 2 << :entry_3
    end
    
    it "returns Enumerator" do 
      expect(storage.each.class).to eq(Enumerator)
    end

    it "allows iteration over stored items and use of methods from Enumerable mixin" do
      expect(storage.map{ |item| item.to_s} ).to eq(["entry_1", "2", "entry_3"]) 
    end
  end
end