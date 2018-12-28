class Image < ApplicationRecord
  # relationships
  belongs_to :location
  mount_uploader :url, ImageUploader

  validates :url, presence: true
end
