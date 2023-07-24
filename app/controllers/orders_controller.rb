class OrdersController < ApplicationController
  before_action :authenticate_user

  def create
    carted_products = CartedProduct.where(user_id: current_user.id, status: "carted")
    subtotal = 0
    carted_products.each do |carted_product|
      product = Product.find_by(id: carted_product.product_id)
      quantity = carted_product.quantity
      subtotal += product.price * quantity
    end
    tax = 0.09 * subtotal
    @order = Order.new(
      user_id: current_user.id,
      subtotal: subtotal,
      tax: tax,
      total: subtotal + tax,
    )
    if @order.save
      carted_products.update_all(status: "purchased", order_id: @order.id)
      render :show
    else
      render json: { errors: @order.errors.full_messages }, status: 422
    end
  end

  def show
    @order = current_user.orders.find_by(id: params[:id])
    render :show
  end

  def index
    @orders = current_user.orders
    render :index
  end
end
