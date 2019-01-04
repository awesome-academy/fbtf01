class Location < ApplicationRecord
  # constant
  IMAGES_COUNT_MIN = 1
  # relationships
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  # M:M relationship between Tours and Locations
  has_many :occurrences
  has_many :tours, through: :occurrences

  # validations
  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validate :check_image_min_numbers, on: :update

  # scopes
  scope :created_at_descending, ->{order(created_at: :desc)}

  private

  def images_count_min_valid?
    images.reject(&:marked_for_destruction?).count >= IMAGES_COUNT_MIN
  end

  def check_image_min_numbers
    errors.add :base, :invalid_images_number unless images_count_min_valid?
  end
end
