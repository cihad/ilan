require 'spec_helper'
require 'catalog'

describe Catalog do

  it "has grouped nodes by category" do
    nodes = double
    expect(described_class.new(nodes).grouped_nodes_by_category).to eq(nodes)
  end

  it "has default column count" do
    expect(described_class.new(double).columns).to eq(3)
  end

  it "has column size" do
    expect(described_class.new(double, columns: 2).columns).to eq(2)
  end

  it "has default node count per column" do
    expect(described_class.new(double).node_count_per_column).to eq(10)
  end

  it "has node count per column" do
    expect(described_class.new(double, node_count_per_column: 12).
      node_count_per_column).to eq(12)
  end

  it "has expected total node count" do
    expect(
      described_class.
        new(double, columns: 3, node_count_per_column: 10).
        expected_total_node_count
    ).to eq(30)
  end

  it "has actual total node count" do
    nodes = double
    nodes.stub_chain(:values, :flatten, :size).and_return(10)
    expect(described_class.new(nodes).actual_total_node_count).to eq(10)
  end

  it "greps to grouped nodes by node percentage" do
    category1, category2 = [double, double]
    node1, node2, node3, node4, node5, node6, node7, node8 = \
      Array.new(8).map { double }

    grouped_nodes = {
      category1 => [node1, node2, node3, node4, node5, node6],
      category2 => [node7, node8]
    }

    expect(
      described_class.
        new(grouped_nodes, columns: 2, node_count_per_column: 2).
        grep_grouped_nodes
    ).to eq({
      category1 => [node1, node2, node3],
      category2 => [node7]  
    })
  end

  context "actual node count" do
    let(:category1) { mock_model Category }
    let(:node1) { mock_model Node }
    let(:node2) { mock_model Node }
    let(:node3) { mock_model Node }

    let(:category2) { mock_model Category }
    let(:node4) { mock_model Node }

    let(:grouped_nodes) {{
      category2 => [node4],
      category1 => [node1, node2, node3]
    }}

    context "when greater than or equal to expected node count" do
      it "gives a catalog" do
        expect(described_class.new(grouped_nodes, columns: 2, node_count_per_column: 2).catalog).to eq([
          [category1, node1, node2],
          [node3, category2, node4] 
        ])
      end
    end

    context "when less than expected node count" do
      it "gives a catalog" do
        expect(described_class.new(grouped_nodes, columns: 2, node_count_per_column: 4).catalog).to eq([ 
          [category1, node1, node2],
          [node3, category2, node4] 
        ])
      end
    end

    it "#sort_by_node_count" do
      grouped_nodes = {
        category2 => [node4],
        category1 => [node1, node2, node3]
      }

      expect(
        described_class.
          new(double).
          sort_by_node_count(grouped_nodes).
          first).to eq(
        [category1, [node1, node2, node3]]
      )
    end
  end
end
