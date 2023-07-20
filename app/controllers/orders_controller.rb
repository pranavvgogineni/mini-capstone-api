class OrdersController < ApplicationController
  before_action :authenticate_user
  
  def create
    product = Product.find_by(id: params[:product_id])
    quantity = params[:quantity].to_i
    subtotal = product.price * quantity
    tax = subtotal * 0.09
    @order = Order.new(
      user_id: current_user.id,
      product_id: params[:product_id],
      quantity: params[:quantity],
      subtotal: subtotal,
      tax: tax,
      total: subtotal + tax,
    )
    if @order.save
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
