class CartController < ApplicationController
  before_action :init_cart

  def index
    @cart_items = Product.where(id: session[:cart].keys)
  end

  def add
    product_id = params[:product_id].to_s
    quantity   = params[:quantity].to_i
    quantity   = 1 if quantity <= 0

    product = Product.find_by(id: product_id)
    return redirect_back fallback_location: root_path,
      alert: "Product not found" unless product

    if product.stock_quantity.to_i < quantity
      return redirect_back fallback_location: root_path,
        alert: "Only #{product.stock_quantity} items available"
    end

    session[:cart][product_id] ||= 0
    session[:cart][product_id] += quantity

    redirect_to cart_index_path, notice: "Product added to cart!"
  end

  def buy_now
    product_id = params[:product_id].to_s
    quantity   = params[:quantity].to_i
    quantity   = 1 if quantity <= 0

    product = Product.find_by(id: product_id)
    return redirect_to root_path, alert: "Product not found" unless product

    if product.stock_quantity.to_i < quantity
      return redirect_back fallback_location: root_path,
        alert: "Only #{product.stock_quantity} items available"
    end

    session[:cart] = {}
    session[:cart][product_id] = quantity

    redirect_to cart_index_path, notice: "Proceed to checkout"
  end

  def remove
    session[:cart].delete(params[:product_id].to_s)
    redirect_to cart_index_path, notice: "Item removed"
  end

  private

  def init_cart
    session[:cart] ||= {}
  end
end
