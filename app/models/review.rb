class Review < ApplicationRecord
  # relationships
  belongs_to :user

  has_many :likes, dependent: :destroy

  # validations
  validates :user_id, presence: true
  validates :tour_id, presence: true

  # scopes
  scope :newest, ->{order created_at: :desc}
  scope :most_likes, (
    lambda do |tour_id|
      joins(:likes)
      .group("reviews.id")
      .having("reviews.tour_id = ?", tour_id)
      .order("count(likes.user_id) desc")
    end)
end
