class AddAccessTokenToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :access_token, :text, null: false, unique: true
    add_column :users, :given_name, :string
    add_column :users, :avatar_url, :string
    add_column :users, :signup_category, :string
  end
end
