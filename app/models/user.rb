class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable,
    authentication_keys: [:login, :shop_id]

  belongs_to :shop
  belongs_to :manager, class_name: 'User'
  has_many :users, foreign_key: :manager_id, dependent: :restrict
  has_many :orders
  has_many :line_items

  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :login, :plaintext_password, :department, :name, :phone, :address, :text,
    :is_manager, :manager_id, :budget, :balance

  validates :login, presence: true
  validates :name, presence: true
  validates_uniqueness_of :login, scope: :shop_id

  default_scope order(:name)
  scope :managers, where(is_manager: true)

  def email_required?
    false
  end
end
