class AddCategoryToNode < ActiveRecord::Migration
  def change
    add_reference :nodes, :category, index: true
  end
end
