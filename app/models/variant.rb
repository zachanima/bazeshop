class Variant < ActiveRecord::Base
  belongs_to :option
  belongs_to :product

  attr_accessible :gross_price, :net_price, :option_id

  def derived_gross_price
    self.gross_price || self.option.gross_price
  end
end
