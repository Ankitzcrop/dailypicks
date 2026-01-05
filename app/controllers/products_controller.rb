class ProductsController < ApplicationController
  def index
    @products = Product.where.not(seller_id: nil).order(created_at: :desc)
  end
  
  def show
    @product = Product.find(params[:id])
  end

  def details
    @product = Product.find(params[:id])
  end
end
