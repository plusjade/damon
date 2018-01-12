class AddGoogleSubToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :google_sub, :string, null: false, unique: true
  end
end
