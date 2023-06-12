class CreateRappers < ActiveRecord::Migration[7.0]
  def change
    create_table :rappers do |t|
      t.string :name
      t.string :genre
      t.string :songs
      t.integer :awards
      t.string :price
      t.float :rating
      t.text :image
      t.integer :user_id

      t.timestamps
    end
  end
end
