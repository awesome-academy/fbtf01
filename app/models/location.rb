class Location < ApplicationRecord
  # relationships
  has_many :images, dependent: :destroy
  # M:M relationship between Tours and Locations
  has_many :occurrences
  has_many :tours, through: :occurrences
end
