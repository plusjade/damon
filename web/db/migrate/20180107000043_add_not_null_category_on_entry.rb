class AddNotNullCategoryOnEntry < ActiveRecord::Migration[5.0]
  def change
    change_column :entries, :category_id, :bigint, null: false
  end
end
