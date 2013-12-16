class AddStatusToNode < ActiveRecord::Migration
  def change
    add_column :nodes, :status, :string
  end
end
