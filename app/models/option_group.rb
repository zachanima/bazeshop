class OptionGroup < ActiveRecord::Base
  belongs_to :option_set

  attr_accessible :name, :position
end
