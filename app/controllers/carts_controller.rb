class CartsController < ApplicationController

  def index
    carts = Cart.all
    render json: carts.to_json(include: [:cart_items => {only: :quantity, include: [:product => {except: :id}]}], except: :id), status: 200
  end

  def show
    cart = Cart.find_by_cart_id(cart_id)
    render json: cart.to_json(include: [:cart_items => {only: :quantity, include: [:product => {except: :id}]}], except: :id), status: 200
  end

  def create
    cart = Cart.new
    cart.save
    render json: cart.to_json(include: [:cart_items => {only: :quantity, include: [:product => {except: :id}]}], except: :id), status: 201
  end

  def add
    cart = Cart.find_by_cart_id(cart_id)
    cart.add_products(products)
    render json: cart.to_json(include: [:cart_items => {only: :quantity, include: [:product => {except: :id}]}], except: :id), status: 200 
  end

  def activate
    cart = Cart.find_by_cart_id(cart_id)
    cart.activate
    render json: cart.to_json(include: [:cart_items => {only: :quantity, include: [:product => {except: :id}]}], except: :id), status: 200
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