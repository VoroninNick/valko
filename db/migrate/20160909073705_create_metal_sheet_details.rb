class CreateMetalSheetDetails < ActiveRecord::Migration
  def change
    create_table :metal_sheet_details do |t|
      t.string :title
      t.string :slug
      t.boolean :published

      t.string :producer
      t.string :thickness
      t.string :coating
      t.string :protective_lamina

      t.attachment :drawing
      t.integer :width

      t.belongs_to :metal_sheet

      t.timestamps null: false
    end
  end
end
