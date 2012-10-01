class LineItem < ActiveRecord::Base
  attr_accessible :product_brand, :gross_price, :net_price, :product_name,
    :product_number, :quantity, :product_supplier_number, :product_id,
    :product_gross_price, :product_net_price

  belongs_to :user
  belongs_to :product
  belongs_to :order
  has_many :variations
  has_many :variants, through: :variations

  default_scope order(:created_at)
  scope :current, where(order_id: nil)

  def set_values
    self.product_name = self.product.name
    self.product_number = self.product.number
    self.product_supplier_number = self.product.supplier_number
    self.product_brand = self.product.brand
    self.product_gross_price = self.product.gross_price if self.product.gross_price
    self.product_net_price = self.product.net_price if self.product.net_price
    self.gross_price = self.product.gross_price if self.product.gross_price
    self.net_price = self.product.net_price if self.product.net_price
    self.variations.each do |variation|
      self.gross_price += variation.variant.derived_gross_price if variation.variant.derived_gross_price and self.gross_price
      self.net_price += variation.variant.derived_net_price if variation.variant.derived_net_price and self.net_price
    end
    self.gross_price *= self.quantity if self.gross_price
    self.net_price *= self.quantity if self.net_price
    self.save
  end
end
