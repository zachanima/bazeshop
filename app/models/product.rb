class Product < ActiveRecord::Base
  belongs_to :category

  attr_accessible :name

  validates :name, presence: true
  validates :category, presence: true
end
