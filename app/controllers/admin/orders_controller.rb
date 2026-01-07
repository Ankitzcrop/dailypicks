# app/controllers/admin/orders_controller.rb
class Admin::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  def index
    @orders = Order.includes(:user).order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])

    if @order.update(status: params[:status])
      redirect_to admin_orders_path,
        notice: "Order status updated successfully"
    else
      redirect_to admin_order_path(@order),
        alert: "Failed to update order status"
    end
  end

  private

  def check_admin
    redirect_to root_path, alert: "Access denied" unless current_user.admin?
  end
end
