class OptionGroup < ActiveRecord::Base
  belongs_to :option_set
  has_many :options, dependent: :restrict

  attr_accessible :name, :position, :options_attributes

  validates :name, presence: true

  default_scope order(:position)

  accepts_nested_attributes_for :options
end
