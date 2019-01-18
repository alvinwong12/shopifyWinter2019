class ProductsController < ApplicationController

  def index
    if query_available_products?
      products = Product.find_by_params(product_params).available_products.limit(amount_to_query)
    else
      products = Product.find_by_params(product_params).limit(amount_to_query)
    end

    render json: products.to_json(:except => [:id]), status: 200
  end

  def show
    product = Product.find_by_product_id(params[:id])
    render json: product.to_json, status: 200
  end

  private
  def product_params
    params.permit(:title, :price, :inventory_count, :product_id)
  end

  def query_available_products?
    params[:available_products_only] == "true"
  end

  def amount_to_query
    params[:count] !~ /\D/ ? params[:count] : nil
  end

end