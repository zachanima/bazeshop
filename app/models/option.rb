class Option < ActiveRecord::Base
  belongs_to :option_group
  has_many :variants

  attr_accessible :name, :position

  validates :name, presence: true

  default_scope order(:position)
end
