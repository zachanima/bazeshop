class Variant < ActiveRecord::Base
  belongs_to :option
  belongs_to :product

  attr_accessible :gross_price, :net_price, :option_id
end
