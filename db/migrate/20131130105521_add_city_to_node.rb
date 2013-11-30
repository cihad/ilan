class AddCityToNode < ActiveRecord::Migration
  def change
    add_reference :nodes, :city, index: true
  end
end
