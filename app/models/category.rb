class Category < ActiveRecord::Base
  belongs_to :shop
  belongs_to :parent, class_name: 'Category'
  has_many :categories, foreign_key: :parent_id
  has_many :products

  attr_accessible :name, :shop_id, :parent_id

  validates :name, presence: true
  validates :shop, presence: true
  validate :existence_of_parent
  validate :absence_of_self_referential_parent

  default_scope order(:name)
  scope :top, where(parent_id: nil)

  def path
    path = [self.name]
    path << self.parent.path if self.parent
    path.reverse.flatten * ' > '
  end

private
  def existence_of_parent
    errors.add('parent') unless self.parent_id.blank? or Category.exists?(self.parent_id)
  end

  def absence_of_self_referential_parent
    errors.add('parent') if self.id and self.parent_id == self.id
  end
end
