class Category < ActiveRecord::Base
  belongs_to :shop
  belongs_to :parent, class_name: 'Category'
  has_many :categories, foreign_key: :parent_id
  has_many :products, dependent: :restrict
  has_many :category_user_order_dates, dependent: :destroy
  has_many :users, through: :category_user_order_dates
  has_and_belongs_to_many :access_groups

  attr_accessible :name, :shop_id, :parent_id, :access_group_ids, :reorder_period

  validates :name, presence: true
  validates :shop, presence: true
  validate :existence_of_parent
  validate :absence_of_self_referential_parent

  default_scope order(:position)
  scope :top, where(parent_id: nil)

  after_save :assign_access_groups_to_parent
  before_destroy :assign_parent_to_categories

  def path
    path = [self.name]
    path << self.parent.path if self.parent
    path.reverse * ' > '
  end

  def indented_name_for_select
    "#{self.indent}#{self.name}".html_safe
  end

  def indent
    self.parent ? "&nbsp;&nbsp;&nbsp;&nbsp;#{self.parent.indent}" : ''
  end

  def self.nested exclude = nil
    all.collect do |category|
      [category, category.categories.nested(exclude)] unless category == exclude
    end.flatten.compact
  end

  def visible? user
    if self.access_groups.empty? or user.access_groups.empty?
      true
    else
      self.access_groups.each do |access_group|
        if user.access_groups.include? access_group
          return true
        end
      end
      false
    end
  end

  def reorderable? user
    if not self.category_user_order_dates.exists? or not user.category_user_order_dates.exists? or self.reorder_period.blank?
      true
    elsif self.reorderable(user) <= Date.today
      true
    else
      false
    end
  end

  def last_order_date user
    if self.category_user_order_dates.exists? and user.category_user_order_dates.exists?
      user_order_date = self.category_user_order_dates.where(user_id: user.id).last
      if user_order_date
        user_order_date.order_date
      else
        nil
      end
    end
  end

  def reorderable user
    if self.category_user_order_dates.exists? or user.category_user_order_dates.empty or not self.reorder_peroid.empty?
      self.last_order_date(user) + self.reorder_period
    else
      Date.today
    end
  end

private
  def existence_of_parent
    errors.add('parent') unless self.parent_id.blank? or Category.exists?(self.parent_id)
  end

  def absence_of_self_referential_parent
    errors.add('parent') if self.id and self.parent_id == self.id
  end

  def assign_access_groups_to_parent
    if self.parent
      self.access_groups.each do |access_group|
        self.parent.access_groups << access_group unless self.parent.access_groups.include? access_group
      end
      self.parent.save
    end
  end

  def assign_parent_to_categories
    self.categories.each do |category|
      category.parent = self.parent
      category.save
    end
  end
end
