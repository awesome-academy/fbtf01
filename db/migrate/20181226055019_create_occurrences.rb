class CreateOccurrences < ActiveRecord::Migration[5.2]
  def change
    create_table :occurrences do |t|
      t.references :tour, foreign_key: true
      t.references :location, foreign_key: true
    end
  end
end
