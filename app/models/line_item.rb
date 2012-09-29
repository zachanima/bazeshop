class LineItem < ActiveRecord::Base
  attr_accessible :brand, :gross_price, :net_price, :product_name,
    :product_number, :quantity, :supplier_number, :product_id

  belongs_to :user
  belongs_to :product
  belongs_to :order

  scope :current, where(order_id: nil)
end
