class OrdersController < ApplicationController
  def create
    product = Product.find_by(id: params[:product_id])
    quantity = params[:quantity].to_i
    subtotal = product.price * quantity
    tax = subtotal * 0.09
    order = Order.new(
      user_id: current_user.id,
      product_id: params[:product_id],
      quantity: params[:quantity],
      subtotal: subtotal,
      tax: tax,
      total: subtotal + tax,
    )
    if order.save
      render json: { message: "Order created successfully" }, status: :created
    else
      render json: { errors: order.errors.full_messages }, status: :bad_request
    end
  end

  def show
    order = Order.find_by(id: params[:id], user_id: current_user.id)
    render json: order.as_json
  end

  def index
    orders = Order.where(user_id: current_user.id)
    render json: orders.as_json
  end
end
