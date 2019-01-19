class Cart < ApplicationRecord
  self.table_name = "carts"

  has_many :cart_items

  before_create :set_cart_id

  def set_cart_id
    self.cart_id = self.hash
  end

  def self.find_by_cart_id(cart_id)
    cart = find_by(cart_id: cart_id)
    if cart.nil? 
      raise ActiveRecord::RecordNotFound.new("Cart \##{cart_id} not found")
    end
    cart
  end

  def add_products(products=[])
    raise ApiExceptions::CartError::ProductAdditionFail.new("Cannot add product to completed Cart \##{self.cart_id}") if completed?
    current_total = self.total
    new_items = []
    products.each do |product|
      p = Product.find_by_product_id(product["product_id"])
      quantity = parse_quantity(product["quantity"])
      next if quantity == 0
      next unless p.available?(quantity)
      cart_item = find_existing_cart_item(p) || CartItem.new
      cart_item.product = p
      cart_item.quantity += quantity
      current_total += quantity * p.price
      new_items << cart_item
    end
    self.cart_items << new_items
    new_items.each do |item|
      item.save
    end
    self.total = current_total
    save
  end

  def completed?
    self.completed == true
  end

  def activate
    raise ApiExceptions::CartError::ActivationFail.new("Cart \##{self.cart_id} already activated") if completed?
    self.cart_items.each do|item|
      raise ApiExceptions::CartError::ActivationFail.new("#{item.quantity} #{item.product.title} is not available") unless item.product.available? item.quantity
      item.product.buy item.quantity
    end
    self.completed = true
    save
  end

  def find_existing_cart_item(product)
    cart_item = self.cart_items.find_by(product_id: product.id)
  end

  def parse_quantity(quantity_string)
    if quantity_string.nil? or !(quantity_string !~ /\D/)
      raise ApiExceptions::CartError::InvalidQuantity.new("Please ensure a valid quantity")
    end
    quantity_string.to_i
  end

end