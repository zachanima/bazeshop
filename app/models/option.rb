class Option < ActiveRecord::Base
  belongs_to :option_group
  has_many :variants, dependent: :restrict

  attr_accessible :name, :position

  validates :name, presence: true

  default_scope order(:position).order(:id)
end
