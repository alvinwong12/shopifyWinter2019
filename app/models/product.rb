class Product < ApplicationRecord
  self.table_name = "products"

  has_many :cart_items

  before_create :set_product_id
  
  scope :find_by_product_id, -> (product_id){ (where(product_id: product_id))}
  scope :find_by_params, -> (product_params){ where(product_params) }
  scope :available_products, -> { (where("inventory_count >= 1"))}
  scope :limit_by_count, -> (count) { limit(count)} 


  def set_product_id
    self.product_id = self.hash
  end

  def available?(amount=1)
    inventory_count >= amount
  end

  def buy(amount=1)
    update(inventory_count: inventory_count - amount)
    save
  end

end
