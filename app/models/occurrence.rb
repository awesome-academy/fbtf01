class Occurrence < ApplicationRecord
  # relationships
  belongs_to :tour
  belongs_to :location
end
