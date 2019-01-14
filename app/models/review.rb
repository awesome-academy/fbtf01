class Review < ApplicationRecord
  # relationships
  belongs_to :user

  has_many :likes, dependent: :destroy

  # validations
  validates :user_id, presence: true
  validates :tour_id, presence: true

  # scopes
  scope :newest, ->{order created_at: :desc}
end
