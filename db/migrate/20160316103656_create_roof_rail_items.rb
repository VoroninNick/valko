class CreateRoofRailItems < ActiveRecord::Migration
  def change
    create_table :roof_rail_items do |t|
      t.string :producer
      t.string :thickness
      t.string :coating
      t.string :protective_lamina

      t.string :title
      t.string :slug

      t.text :short_description
      t.text :description
      t.boolean :published

      t.attachment :drawing
      t.integer :width
      t.string :item_type

      t.timestamps null: false
    end
  end
end
