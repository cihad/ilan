class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.references :node, index: true
      t.string :image_uid
      t.string :image_name

      t.timestamps
    end
  end
end
