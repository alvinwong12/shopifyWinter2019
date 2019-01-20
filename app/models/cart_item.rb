class CartItem < ApplicationRecord
  self.table_name = "cart_items"

  belongs_to :cart
  belongs_to :product

  before_create :set_cart_item_id

  def set_cart_item_id
    self.cart_item_id = self.hash.abs.to_s
  end
end