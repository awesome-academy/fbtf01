class Booking < ApplicationRecord
  # enum
  enum status: {pending: 0, approved: 1, canceled: 2}

  # relationships
  belongs_to :user
  belongs_to :tour

  # validations
  validates :number_passengers, presence: true, numericality: true
  validates :total_price, presence: true, numericality: true
  validate :pass_max_passengers, on: :create

  # scopes
  scope :newest, ->{order created_at: :desc}

  private

  def pass_max_passengers
    tour = Tour.find_by id: tour_id
    count = 0
    tour.bookings.each do |booking|
      count += booking.number_passengers if booking.approved?
    end
    left = tour.max_passengers - count
    count += number_passengers
    return unless count > tour.max_passengers

    errors.add :base, :max_passengers_reached, left: left
  end
end
