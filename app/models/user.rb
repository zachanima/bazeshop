class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable,
    authentication_keys: [:login, :shop_id]

  belongs_to :shop
  belongs_to :manager, class_name: 'User'
  has_many :users, foreign_key: :manager_id, dependent: :restrict
  has_many :orders, dependent: :destroy
  has_many :line_items
  has_many :category_user_order_dates, dependent: :destroy
  has_many :categories, through: :category_user_order_dates
  has_and_belongs_to_many :access_groups

  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :login, :plaintext_password, :department, :name, :phone, :address, :text,
    :is_manager, :manager_id, :budget, :balance, :is_demo, :access_group_ids,
    :is_catalogue, :fields, :superuser, :is_active

  validates :login, presence: true
  validates :name, presence: true
  validates :password, presence: true, on: :create
  validates_uniqueness_of :login, scope: :shop_id

  default_scope order(:name)
  scope :managers, where(is_manager: true)

  def email_required?
    false
  end

  def product_in_cart? product
    self.line_items.current.where(product_id: product.id).exists?
  end
end
