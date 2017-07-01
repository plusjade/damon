class AddTableVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :videos do |t|
      t.string :name
      t.string :token, index: true, unique: true
      t.text :payload
      t.string :audio_url
      t.string :version
      t.timestamps
    end
  end
end
