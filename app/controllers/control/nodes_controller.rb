require 'node_filter'

module Control
  class NodesController < BaseController
    def index
      @node_filter = NodeFilter.new(params[:node_filter] || {})
      @nodes = Node.where(status: @node_filter.status)
    end

    def update
      @node = Node.find(params[:id])
      @node.send(:"#{params[:event]}!")
      redirect_to control_nodes_path
    end
  end
end