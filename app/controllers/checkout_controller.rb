class CheckoutController < ApplicationController
  before_action :init_cart

  def index
    @products = Product.where(id: session[:cart].keys)
    @total = calculate_total
  end

  def place_order
    order = Order.create!(
      user: current_user,
      total_amount: calculate_total,
      status: "placed",
      full_name: params[:full_name],
      phone: params[:phone],
      address_line1: params[:address_line1],
      address_line2: params[:address_line2],
      city: params[:city],
      state: params[:state],
      pincode: params[:pincode]
    )

    session[:cart].each do |product_id, qty|
      product = Product.find(product_id)

      OrderItem.create!(
        order: order,
        product: product,
        quantity: qty,
        price: product.discount_price.presence || product.price
      )

      product.update!(stock_quantity: product.stock_quantity - qty)
    end

    session[:cart] = {}
    redirect_to order_path(order), notice: "Order placed successfully!"
  end

  private

  def init_cart
    session[:cart] ||= {}
  end

  def calculate_total
    session[:cart].sum do |product_id, qty|
      product = Product.find(product_id)
      (product.discount_price.presence || product.price) * qty
    end
  end
end
