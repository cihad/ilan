class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :title
      t.text :description
      t.text :contact
      t.string :email

      t.timestamps
    end
  end
end
