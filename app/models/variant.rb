class Variant < ActiveRecord::Base
  belongs_to :option
  belongs_to :product
  has_many :variations
  has_many :line_items, through: :variations

  attr_accessible :gross_price, :net_price, :option_id

  def derived_gross_price
    self.gross_price || self.option.gross_price
  end

  def derived_net_price
    self.net_price || self.option.net_price
  end
end
