class CreateChoicestItemDetails < ActiveRecord::Migration
  def change
    create_table :choicest_item_details do |t|
      t.string :title
      t.string :slug
      t.boolean :published

      t.string :producer
      t.string :thickness
      t.string :coating
      t.string :protective_lamina

      t.attachment :drawing
      t.integer :width

      t.belongs_to :choicest_item

      t.timestamps null: false
    end
  end
end
