class AddAuthenticationTokenToUsers < ActiveRecord::Migration
  def change
    add_index :users, :auth_token, unique: true
  end
end