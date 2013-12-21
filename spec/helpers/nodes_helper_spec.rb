require 'spec_helper'

describe NodesHelper do

  it "#truncated_node_title" do
    node = double title: "a" * 40
    expect(helper.truncated_node_title(node).size).to eq(30)
  end

end
