class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :address
      t.string :phone
      t.integer :role, default: 0
      t.string :password_digest
      t.string :reset_digest
      t.datetime :reset_sent_at
      t.string :customer_id
      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :phone, unique: true
  end
end
