class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|
      t.decimal :quantity, default: 0
    
      t.belongs_to :cart
      t.belongs_to :product
      t.timestamps
    end

  end
end
