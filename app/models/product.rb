class Product < ApplicationRecord
  self.table_name = "products"

  has_many :cart_items, dependent: :destroy

  before_create :set_product_id
  
  scope :find_by_params, -> (product_params){ where(product_params) }
  scope :available_products, -> { (where("inventory_count >= 1")) }

  def self.find_by_product_id(product_id)
    product = find_by(product_id: product_id)
    if product.nil? 
      raise ActiveRecord::RecordNotFound.new("Product \##{product_id} not found")
    end
    product
  end

  def self.find_products(product_params, available_only=false, count=nil)
    if available_only
      products = find_by_params(product_params).available_products.limit(count)
    else
      products = find_by_params(product_params).limit(count)
    end
    products
  end

  def set_product_id
    self.product_id = self.hash.abs.to_s
  end

  def available?(amount=1)
    inventory_count >= amount
  end

  def buy(amount=1)
    update(inventory_count: inventory_count - amount)
    save
  end

end
