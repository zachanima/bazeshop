class Shop < ActiveRecord::Base
  Locales = { en: 'English', da: 'Danish' }
  has_many :categories, dependent: :restrict
  has_many :products, through: :categories
  has_many :users, dependent: :restrict
  has_many :access_groups, dependent: :restrict

  attr_accessible :name, :link, :locale, :login_text, :password_text, :text, :currency, :header_style, :link_style, :receipt_text, :correspondent, :shipping_price, :free_shipping_over, :custom_style, :is_closed, :logo

  validates :name, presence: true
  validates :link, presence: true, uniqueness: true
  validates :locale, presence: true, inclusion: %w[en da]
  validates :shipping_price, numericality: true, allow_nil: true
  validates :free_shipping_over, numericality: true, allow_nil: true

  before_save lambda { |shop| shop.link = shop.link.parameterize }

  default_scope order(:name)

  mount_uploader :logo, LogoUploader

  def closed?
    self.is_closed
  end

  # Determines whether to display advanced settings in form.
  def advanced?
    not (self.custom_style.blank? and self.receipt_text.blank? and self.correspondent.blank? and self.shipping_price.blank? and self.free_shipping_over.blank? and self.is_closed.blank?)
  end

  def orders
    Order.joins(:user).where('users.shop_id = ?', self.id)
  end

  def to_param
    self.link
  end
end
