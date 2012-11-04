class AccessGroup < ActiveRecord::Base
  belongs_to :shop

  attr_accessible :name

  validates :name, presence: true
end
