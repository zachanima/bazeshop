class CategoryUserOrderDate < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  attr_accessible :order_date, :category_id
end
