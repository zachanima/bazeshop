class OptionSet < ActiveRecord::Base
  has_many :option_groups, dependent: :restrict

  attr_accessible :name, :optional, :position, :text, :option_groups_attributes

  validates :name, presence: true

  default_scope order(:position)

  accepts_nested_attributes_for :option_groups
end
