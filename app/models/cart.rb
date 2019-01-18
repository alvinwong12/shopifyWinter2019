class Cart < ApplicationRecord
  self.table_name = "carts"

  has_many :cart_items

  scope :find_by_cart_id, -> (cart_id) { where(cart_id: cart_id) }

  before_create :set_cart_id

  def set_cart_id
    self.cart_id = self.hash
  end

  def add_products(products=[])
    return false if completed?
    current_total = self.total
    new_items = []
    products.each do |product|
      p = Product.find_by_product_id(product["product_id"]).first
      quantity = parse_quantity(product["quantity"]) || 1
      next unless p.available?(quantity)
      cart_item = find_existing_cart_item(p) || CartItem.new
      cart_item.product = p
      cart_item.quantity += quantity
      current_total += quantity * p.price
      cart_item.save
      new_items << cart_item unless (self.cart_items.include?(cart_item) || new_items.include?(cart_item) )
    end
    self.cart_items << new_items
    self.total = current_total
    save
  end

  def completed?
    self.completed == true
  end

  def activate
    self.cart_items.each do|item|
      return false unless item.product.available? item.quantity
      item.product.buy item.quantity
    end
    self.completed = true
    save
  end

  def find_existing_cart_item(product)
    cart_item = self.cart_items.find_by(product_id: product.id)
  end

  def parse_quantity(quantity_string)
    quantity_string !~ /\D/ ? quantity_string.to_i: nil
  end

end