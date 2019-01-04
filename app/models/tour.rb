class Tour < ApplicationRecord
  # relationships
  belongs_to :category

  has_many :reviews, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :bookings, dependent: :destroy

  # M:M relationship between Tours and Locations
  has_many :occurrences
  has_many :locations, through: :occurrences

  # validations
  validates :name, presence: true, uniqueness: {case_sensitive: false}

  # scopes
  scope :imminent, ->{order :date_from}
  scope :same_kind, ->(id){where(category_id: id).order :date_from}
  scope :name_contains, ->(search){where "name LIKE ?", "%#{search}%"}
  scope :duration, (lambda do |date_from, date_to|
    where "date_from >= ? AND date_to <= ?", date_from, date_to
  end)
end
