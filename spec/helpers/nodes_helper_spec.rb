require 'spec_helper'

describe NodesHelper do

  it "#truncated_node_title" do
    node = double title: "a" * 40
    expect(helper.truncated_node_title(node).size).to eq(30)
  end

  it "#decorate_bold" do
    str = "Lorem Ipsum Dolor Lorem Ipsum"
    expect(helper.decorate_bold(str)).to like_of %Q{
      <strong>Lorem Ipsum</strong> Dolor Lorem Ipsum
    }

    str = "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris
          nisi ut aliquip ex ea commodo consequat."
    expect(helper.decorate_bold(str)).to like_of %Q{
      <strong>Ut enim ad</strong> minim veniam, quis nostrud exercitation
      ullamco laboris nisi ut aliquip ex ea commodo consequat.
    }    
  end

end
