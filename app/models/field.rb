class Field < ActiveRecord::Base
  belongs_to :shop

  attr_accessible :required, :text

  validates :text, presence: true
end
