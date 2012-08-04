class Shop < ActiveRecord::Base
  Locales = { en: 'English' }
  has_many :categories

  attr_accessible :name, :link, :locale, :login_text, :password_text, :text, :currency, :border_style, :link_style, :receipt_text, :correspondent, :shipping_price, :free_shipping_over, :custom_style

  validates :name, presence: true
  validates :link, presence: true, uniqueness: true
  validates :locale, presence: true, inclusion: %w[en]

  before_save lambda { |shop| shop.link = shop.link.parameterize }
end
