class Tour < ApplicationRecord
  # relationships
  belongs_to :category

  has_many :reviews, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :bookings, dependent: :destroy

  # M:M relationship between Tours and Locations
  has_many :occurrences
  has_many :locations, through: :occurrences
end
