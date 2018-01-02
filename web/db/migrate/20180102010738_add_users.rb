class AddUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email, index: true, unique: true
      t.timestamps
    end

    if column_exists? :entries, :users_id
      rename_column :entries, :users_id, :user_id
    end
  end
end
