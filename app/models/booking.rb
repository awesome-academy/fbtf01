class Booking < ApplicationRecord
  # enum
  enum status: {pending: 0, approve: 1, cancel: 2}

  # relationships
  belongs_to :user
  belongs_to :tour
end
