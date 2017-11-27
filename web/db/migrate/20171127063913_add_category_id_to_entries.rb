class AddCategoryIdToEntries < ActiveRecord::Migration[5.0]
  def change
    rename_column :entries, :category, :old_category
    add_column :entries, :category_id, :bigint
  end
end
