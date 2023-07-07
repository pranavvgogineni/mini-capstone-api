class ProductsController < ApplicationController
  def index
    products = Product.all
    render json: products.as_json
  end

  def show
    products = Product.find_by(id: params["id"])
    render json: products.as_json
  end

  def create
    product = Product.create(
      name: "Video game",
      price: 60,
      image_url: "insert",
      description: "Game meant for fun played on console",
    )
    render json: product.as_json
  end
end
