class Photo < ApplicationRecord
  belongs_to :room
  has_attached_file :image
  mount_uploader :image, ImageUploader
end
