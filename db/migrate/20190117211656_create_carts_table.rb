class CreateCartsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.string :cart_id, unique: true
      t.decimal :total, scale: 2, precision: 10, default: 0.00
      t.boolean :completed, default: false

    end
  end
end
