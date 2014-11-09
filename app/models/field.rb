class Field < ActiveRecord::Base
  belongs_to :shop

  attr_accessible :is_receipt_email, :required, :text

  validates :text, presence: true
end
