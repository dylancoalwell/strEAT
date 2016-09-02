class AddUserColumns < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :email, :string
    add_column :users, :phone, :string
    add_column :users, :password_digest, :string
  end
end
