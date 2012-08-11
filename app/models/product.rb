class Product < ActiveRecord::Base
  belongs_to :category
  has_one :shop, through: :category
  has_many :images, dependent: :destroy

  attr_accessible :name, :number, :supplier_number, :brand, :text, :gross_price, :net_price, :environment_fee, :parcel_size, :category_id, :images_attributes

  validates :name, presence: true
  validates :category, presence: true
  validates :gross_price, numericality: true, allow_nil: true
  validates :net_price, numericality: true, allow_nil: true
  validates :environment_fee, numericality: true, allow_nil: true
  validates :parcel_size, numericality: { only_integer: true }, allow_nil: true

  accepts_nested_attributes_for :images

  default_scope order(:position)

  def advanced?
    not (self.environment_fee.blank? and self.parcel_size.blank?)
  end
end
