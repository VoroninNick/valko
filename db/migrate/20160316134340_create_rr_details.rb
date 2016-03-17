class CreateRrDetails < ActiveRecord::Migration
  def change
    create_table :rr_details do |t|
      t.string :title
      t.attachment :image
      t.integer :price
      t.boolean :published
      t.belongs_to :roof_rail_item

      t.timestamps null: false
    end
  end
end
