require 'catalog'

class HomePageController < ApplicationController
  def index
    grouped_nodes = Node.group_by_category current_city
    @catalog = Catalog.new(grouped_nodes).catalog
  end
end
