class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, # :registerable, :recoverable,
    :rememberable, :trackable, :validatable, authentication_keys: [:login, :shop_id]

  belongs_to :shop

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :login, :plaintext_password, :department, :name
  # attr_accessible :title, :body

  validates :login, presence: true
  validates :name, presence: true

  def email_required?
    false
  end
end
