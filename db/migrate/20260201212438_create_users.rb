class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.integer :age, default: 0
      t.boolean :is_superuser, default: false
      t.boolean :is_staff, default: false
      t.boolean :is_active, default: true
      t.datetime :date_joined

      t.timestamps
    end
    add_index :users, :username
    add_index :users, :email
  end
end
