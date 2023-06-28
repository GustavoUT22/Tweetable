class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  #Associations
  has_many :tweets, dependent: :destroy
  #=====================================
  has_many :likes, dependent: :destroy
  #=====================================
  has_one_attached :avatar
  #Validations

  validates :name, presence: :true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :username, presence: true, uniqueness: true, length: { maximum: 16 }
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true

  enum :role, {
    member: 0,
    admin: 1
  }, _default: 0

  def self.from_omniauth(auth_hash)
    # Retorna un usuario si lo encuentra
    # Si no lo encuentra
      # Crea al usuario
      # Luego lo retorna

    where(provider: auth_hash.provider, uid: auth_hash.uid).first_or_create do |user|
      user.provider = auth_hash.provider
      user.uid = auth_hash.uid
      user.username = auth_hash.info.name
      user.email = auth_hash.info.email
      user.password = Devise.friendly_token
    end
  end
end
