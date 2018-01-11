class AddPromptTable < ActiveRecord::Migration[5.0]
  def change
    create_table :prompts do |t|
      t.string :key
      t.string :prompt
      t.string :custom_prompt
      t.text :choices, array: true, default: []
      t.integer :position
      t.references :category
      t.timestamps
    end

    add_index :prompts, [:key, :category_id], unique: true
  end
end
