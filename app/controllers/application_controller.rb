class ApplicationController < ActionController::Base
  helper_method :cart_count

  before_action :set_order_count

  private

  def cart_count
    return 0 unless session[:cart].present?

    # sirf unique products count
    session[:cart].keys.count
  end

  def set_order_count
    return unless current_user

    @order_count =
      if current_user.admin?
        Order.count
      else
        current_user.orders.count
      end
  end

end
