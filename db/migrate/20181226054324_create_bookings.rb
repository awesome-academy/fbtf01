class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.integer :number_passengers
      t.integer :status, default: 0
      t.float :total_price
      t.references :user, foreign_key: true
      t.references :tour, foreign_key: true
      t.timestamps
    end
  end
end
