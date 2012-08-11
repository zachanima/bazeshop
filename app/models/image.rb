class Image < ActiveRecord::Base
  belongs_to :product

  attr_accessible :image

  mount_uploader :image, ImageUploader
end
