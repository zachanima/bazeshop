class Category < ActiveRecord::Base
  belongs_to :shop

  attr_accessible :name

  validates :name, presence: true
  validates :shop, presence: true
end
