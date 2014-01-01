class Catalog

  attr_reader :grouped_nodes_by_category, :columns, :node_count_per_column

  def initialize grouped_nodes_by_category, opts = {}
    @grouped_nodes_by_category = grouped_nodes_by_category
    @columns = opts.fetch(:columns, 3)
    @node_count_per_column = opts.fetch(:node_count_per_column, 10)
  end

  def expected_total_node_count
    @expected_total_node_count ||= columns * node_count_per_column
  end

  def actual_total_node_count
    @actual_total_node_count ||= grouped_nodes_by_category.values.flatten.size
  end

  def grep_grouped_nodes
    if actual_total_node_count < expected_total_node_count
      grouped_nodes_by_category
    else
      grouped_nodes_by_category.inject({}) do |hash, category_nodes|
        category, nodes = category_nodes
        percentage = nodes.size.to_f / actual_total_node_count
        hash[category] = nodes.take((percentage * expected_total_node_count).floor)
        hash
      end
    end
  end

  # input => grouped_nodes = {
  #   <Category1> => [<Node1>, <Node2>],
  #   <Category2> => [<Node3>, <Node4>, <Node5>]
  # }
  #
  # output => [
  #   [<Category2>, [<Node3>, <Node4>, <Node5>]],
  #   [<Category1>,[<Node1>, <Node2>]]
  # ]
  def sort_by_node_count grouped_nodes
    grouped_nodes.to_a.sort { |a, b| b.last.size <=> a.last.size }
  end

  def catalog
    catalog = sort_by_node_count(grep_grouped_nodes).flatten.in_groups(columns, false)
    category_class = catalog.first.first.class


    # input => catalog == [
    #   [<Category1>, <Node1>, <Node2>, <Category2>],
    #   [<Node3>, <Node4>, <Category3>, <Node5>]
    # ]
    #
    # output => catalog == [
    #   [<Category1>, <Node1>, <Node2>],
    #   [<Category2>, <Node3>, <Node4>, <Category3>, <Node5>]
    # ]
    (0...catalog.size).each do |i|
      if catalog[i].last.class == category_class
        category = catalog[i].pop
        catalog[i+1].unshift(category)
      end
    end

    catalog
  end
end