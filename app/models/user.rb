class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable, :validatable,
    authentication_keys: [:login, :shop_id]

  belongs_to :shop

  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :login, :plaintext_password, :department, :name

  validates :login, presence: true
  validates :name, presence: true

  def email_required?
    false
  end
end
