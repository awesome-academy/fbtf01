class CreateTours < ActiveRecord::Migration[5.2]
  def change
    create_table :tours do |t|
      t.string :name
      t.text :description
      t.datetime :date_from
      t.datetime :date_to
      t.integer :min_passengers
      t.integer :max_passengers
      t.float :price
      t.references :category, foreign_key: true
      t.timestamps
    end

    add_index :tours, [:name, :created_at]
    add_index :tours, [:category_id, :created_at]
  end
end
