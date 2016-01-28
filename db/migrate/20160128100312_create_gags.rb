class CreateGags < ActiveRecord::Migration
  def change
    create_table :gags do |t|
      t.string :title
      t.string :slug
      t.belongs_to :brand
      t.attachment :image
      t.text :description
      t.boolean :published
      t.integer :price

      t.timestamps null: false
    end
  end
end
