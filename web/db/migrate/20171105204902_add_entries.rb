class AddEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :entries do |t|
      t.references :users
      t.text :value
      t.string :category
      t.string :ordinal
      t.timestamp :occurred_at, index: true, null: false
      t.timestamps
    end
  end
end
