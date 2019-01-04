class Like < ApplicationRecord
  # relationships
  belongs_to :user
  belongs_to :review

  # validations
  validates :user_id, presence: true
  validates :review_id, presence: true
end
