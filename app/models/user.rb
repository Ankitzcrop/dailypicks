class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

           enum role: { user: "user", admin: "admin" }

         has_one_attached :philippine_government_id_card
         has_one_attached :address_proof
         has_one_attached :logo
         has_one :cart, dependent: :destroy
         has_many :orders, dependent: :destroy

         
         validates :name, :email, :mobile, :store_name, presence: true, if: :seller?
         validates :mobile, format: { with: /\A\+63\d{10}\z/, message: "must start with +63 and have 10 digits", if: :seller? }
         validates :agreement, acceptance: { message: 'must be accepted to proceed' }, if: :seller?
         validates :tax_identification_number, format: { with: /\A\d{9}\z/, message: "must be a 9-digit TIN" }, allow_blank: true, if: :seller?
       
         # File attachments validations (optional, if using Active Storage)
         validates :philippine_government_id_card, presence: true, if: :seller?
         validates :address_proof, presence: true, if: :seller?
         validates :logo, presence: true, if: :seller?
         private

         def seller?
           seller == true
         end       
end
