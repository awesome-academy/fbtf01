class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :name
      t.text :description
      t.timestamps
    end

    add_index :locations, :name, unique: true
  end
end
