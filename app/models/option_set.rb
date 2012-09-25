class OptionSet < ActiveRecord::Base
  attr_accessible :name, :optional, :position, :text

  validates :name, presence: true

  default_scope order(:position)
end
