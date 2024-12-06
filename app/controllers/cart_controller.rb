class CartController < ApplicationController
  def index
    @cart = session[:cart] || []
  end

  def add
    session[:cart] ||= []
    session[:cart] << params[:product_id]
    redirect_to cart_index_path, notice: "Product added to cart!"
  end
end
