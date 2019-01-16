class Like < ApplicationRecord
  # relationships
  belongs_to :user
  belongs_to :review
end
