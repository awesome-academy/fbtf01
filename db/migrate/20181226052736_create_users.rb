class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, null: false, default: ""
      t.string :address
      t.string :phone
      t.integer :role, default: 0
      t.string :customer_id
      t.timestamps
    end
  end
end
