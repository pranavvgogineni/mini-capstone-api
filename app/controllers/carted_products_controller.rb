class CartedProductsController < ApplicationController
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
end
