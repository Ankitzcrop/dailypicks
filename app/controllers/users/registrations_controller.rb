class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, only: [:new, :create]
  
  def new
    @is_seller = params[:seller] == "true"
    super
  end
  

  protected
  
  # Add custom parameters for sign-up
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
       :name, :mobile, :store_name, :business_name, :tax_identification_number, :philippine_government_id_card, 
      :address_proof, :logo, :region, :city, :barangay, :dti_sec_registration_number, :agreement, :seller
    ])
  end
end
