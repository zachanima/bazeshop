class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable, :validatable,
    authentication_keys: [:login, :shop_id]

  belongs_to :shop
  belongs_to :manager, class_name: 'User'
  has_many :users, foreign_key: :manager_id, dependent: :restrict

  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :login, :plaintext_password, :department, :name, :phone, :address, :text,
    :is_manager, :manager_id

  validates :login, presence: true
  validates :name, presence: true

  default_scope order(:name)
  scope :managers, where(is_manager: true)

  def email_required?
    false
  end
end
