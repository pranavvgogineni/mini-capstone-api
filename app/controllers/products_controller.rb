class ProductsController < ApplicationController
  def print_products
    products = Product.all
    render json: products.as_json
  end
end
