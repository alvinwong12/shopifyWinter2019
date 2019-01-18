class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|
      t.decimal :quantity, default: 0
      t.string :cart_item_id, unique: true
      
      t.belongs_to :cart
      t.belongs_to :product
      t.timestamps
    end

  end
end
