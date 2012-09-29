class Variation < ActiveRecord::Base
  belongs_to :variant
  belongs_to :line_item

  attr_accessible :gross_price, :net_price, :option_name, :option_set_name, :variant_id
end
