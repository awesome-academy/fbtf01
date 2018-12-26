class Booking < ApplicationRecord
  # enum
  enum status: {reject: 0, approve: 1, pending: 2}

  # relationships
  belongs_to :user
  belongs_to :tour
end
