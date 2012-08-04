class Shop < ActiveRecord::Base
  has_many :categories

  attr_accessible :name, :link, :locale

  validates :name, presence: true
  validates :link, presence: true, uniqueness: true
  validates :locale, presence: true, inclusion: %w[en]

  before_save lambda { |shop| shop.link = shop.link.parameterize }
end
