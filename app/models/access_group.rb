class AccessGroup < ActiveRecord::Base
  belongs_to :shop
  has_and_belongs_to_many :categories

  attr_accessible :name

  validates :name, presence: true
end
