class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name, limit: 50
      t.string :last_name, limit: 50
      t.string :email
      t.string :password
      t.string :password

      t.timestamps null: false
    end
  end
end
