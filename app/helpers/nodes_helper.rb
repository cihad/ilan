module NodesHelper

  def truncated_node_title node = @node
    node.title.truncate(30)
  end

end
