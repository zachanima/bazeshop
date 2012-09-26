class Option < ActiveRecord::Base
  belongs_to :option_group
  has_many :variants, dependent: :restrict

  attr_accessible :name, :position, :net_price, :gross_price

  validates :name, presence: true

  default_scope order(:position).order(:id)
end
