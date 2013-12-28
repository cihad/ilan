class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @nodes = @category.
              nodes.
              with_published_state.
              order(:updated_at).
              page(params[:page]).
              per(20)
  end
end
