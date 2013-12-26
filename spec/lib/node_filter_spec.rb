require 'node_filter'

describe NodeFilter do

  describe "#status" do
    it "returns pending_approval with empty hash" do
      with_empty_hash = {}
      expect(described_class.new(with_empty_hash).status).to eq("pending_approval")
    end

    it "returns pending_approval with empty status string" do
      with_empty_string = { status: "" }
      expect(described_class.new(with_empty_string).status).to eq("pending_approval")
    end

    it "returns params status with status" do
      with_status = { status: "sample" }
      expect(described_class.new(with_status).status).to eq("sample")
    end
  end

end