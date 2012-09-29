class Order < ActiveRecord::Base
  attr_accessible :gross_price, :net_price, :user_name, :user_id, :comment

  belongs_to :user
  has_many :line_items, dependent: :destroy
end
