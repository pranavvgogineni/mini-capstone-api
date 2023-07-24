class CartedProductsController < ApplicationController
  before_action :authenticate_user

  def create
    @carted_product = CartedProduct.create!(
      user_id: current_user.id,
      product_id: params[:product_id],
      quantity: params[:quantity],
      status: "carted",
    )
    if @carted_product
      render :show
    else
      render json: { errors: @carted_product.errors.full_messages }, status: 422
    end
  end

  def index
    @carted_products = current_user.carted_products.where(status: "carted")
    if @carted_products
      render :index
    else
      render json: { message: "cart empty" }
    end
  end

  def destroy
    @carted_product = CartedProduct.find_by(id: params[:id])
    @carted_product.update(status: "removed")
    render json: {
      message: "Carted product successfully deleted.",
    }
  end
end
