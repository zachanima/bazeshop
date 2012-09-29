class LineItem < ActiveRecord::Base
  attr_accessible :product_brand, :gross_price, :net_price, :product_name,
    :product_number, :quantity, :product_supplier_number, :product_id,
    :product_gross_price, :product_net_price

  belongs_to :user
  belongs_to :product
  belongs_to :order
  has_many :variations
  has_many :variants, through: :variations

  scope :current, where(order_id: nil)
end
