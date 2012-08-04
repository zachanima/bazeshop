class Shop < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true
  validates :link, presence: true
end
