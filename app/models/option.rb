class Option < ActiveRecord::Base
  belongs_to :option_group

  attr_accessible :name, :position

  validates :name, presence: true

  default_scope order(:position)
end
