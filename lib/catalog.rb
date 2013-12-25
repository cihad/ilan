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
    @grep_grouped_nodes ||= grouped_nodes_by_category.inject({}) do |hash, category_nodes|
      category, nodes = category_nodes
      percentage = nodes.size.to_f / actual_total_node_count
      hash[category] = nodes.take((percentage * expected_total_node_count).floor)
      hash
    end
  end

  def sort_by_node_count grouped_nodes
    sorted_array = grouped_nodes.to_a.sort do |a, b|
      b.last.size <=> a.last.size
    end.inject({}) do |hash, arr|
      hash[arr.first] = arr.last
      hash
    end
  end

  def catalog
    catalog = Array.new(columns) { [] }
    column = 0

    if actual_total_node_count < expected_total_node_count
      node_count_each_column = (actual_total_node_count.to_f / columns).floor
      grouped_nodes = grouped_nodes_by_category
    else
      node_count_each_column = node_count_per_column
      grouped_nodes = grep_grouped_nodes
    end

    sort_by_node_count(grouped_nodes).each do |category, nodes|
      column += 1 unless node_count_for(catalog[column]) < node_count_each_column
      catalog[column] << category

      nodes.each do |node|
        column += 1 unless node_count_for(catalog[column]) < node_count_each_column
        catalog[column] << node
      end
    end

    catalog
  end

  private

  def node_count_for arr
    arr.count { |thing| thing.is_a? Node }
  end

end