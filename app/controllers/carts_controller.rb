class CartsController < ApplicationController

  def index
    carts = Cart.all
    render json: carts.to_json(include: :cart_items), status: 200
  end

  def show
    cart = Cart.find_by_cart_id(cart_id)
    render json: cart.to_json(include: :cart_items), status: 200
  end

  def create
    cart = Cart.new
    cart.save
    render json: cart.to_json(include: :cart_items), status: 200
  end

  def add
    # cannot add product if purchase is compledted
    cart = Cart.find_by_cart_id(cart_id).first
    cart.add_products(products)
    render json: cart.to_json(include: :cart_items), status: 200 
  end

  def activate
    cart = Cart.find_by_cart_id(cart_id).first
    cart.activate unless cart.nil?
    render json: cart.to_json(include: :cart_items), status: 200
  end

  private

  def products
    body = JSON.parse request.body.read()
    body["products"]
  end

  def cart_id
    params.require(:id)
  end

end