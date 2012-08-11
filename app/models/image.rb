class Image < ActiveRecord::Base
  belongs_to :product

  attr_accessible :image

  default_scope order(:position)

  mount_uploader :image, ImageUploader
end
