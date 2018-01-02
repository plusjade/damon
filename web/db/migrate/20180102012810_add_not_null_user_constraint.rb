class AddNotNullUserConstraint < ActiveRecord::Migration[5.0]
  def change
    change_column :categories, :user_id, :bigint, null: false
    change_column :entries, :user_id, :bigint, null: false
  end
end
