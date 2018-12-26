class Rate < ApplicationRecord
  # relationships
  belongs_to :user
  belongs_to :tour
end
