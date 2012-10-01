class OptionSet < ActiveRecord::Base
  has_many :option_groups, dependent: :restrict

  attr_accessible :name, :optional, :position, :text, :option_groups_attributes

  validates :name, presence: true

  default_scope order(:position)

  accepts_nested_attributes_for :option_groups

  def <=> other
    self.position <=> other.position
  end

  def options
    self.option_groups.collect do |option_group|
      option_group.options
    end.flatten
  end

  def name_with_text
    "#{self.name} (#{self.text})"
  end

  def self.exclude option_sets
    self.all.reject do |option_set|
      option_sets.include? option_set
    end
  end
end
