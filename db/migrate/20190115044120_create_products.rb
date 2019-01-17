class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :product_id, unique: true
      t.string :title
      t.decimal :price, scale: 2, precision: 10, default: 0
      t.integer :inventory_count, default: 0

      t.timestamps
    end


  end
end
