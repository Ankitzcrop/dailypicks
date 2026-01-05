class Admin::ProductsController < Admin::BaseController
  before_action :set_product, only: [:edit, :update, :destroy]

  # GET /admin/products
  def index
    @products = Product.includes(subcategory: :category)
                       .order(created_at: :desc)
  end

  # GET /admin/products/new
  def new
    @product = Product.new
  end

  # POST /admin/products
  def create
    category = Category.find_or_create_by!(name: "Clothing")

    subcategory = Subcategory.find_or_create_by!(
      name: params[:subcategory_name].to_s.strip,
      category: category
    )

    @product = Product.new(product_params)
    @product.subcategory = subcategory
    @product.seller = current_user

    if @product.save
      redirect_to admin_products_path, notice: "Product added successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /admin/products/:id/edit
  def edit
    @subcategory_name = @product.subcategory&.name
  end

  # PATCH/PUT /admin/products/:id
  def update
    category = Category.find_or_create_by!(name: "Clothing")

    subcategory = Subcategory.find_or_create_by!(
      name: params[:subcategory_name].to_s.strip,
      category: category
    )

    @product.subcategory = subcategory

    if @product.update(product_params)
      redirect_to admin_products_path, notice: "Product updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /admin/products/:id
  def destroy
    @product.destroy
    redirect_to admin_products_path, notice: "Product deleted successfully"
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :price,
      :discount_price,
      :stock_quantity,
      :unit,
      :brand,
      :image,
      :thumbnail_url,
      :is_featured,
      tags: []
    )
  end
end
