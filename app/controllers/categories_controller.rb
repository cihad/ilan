class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @nodes = @category.nodes.order(:updated_at)
  end
end
