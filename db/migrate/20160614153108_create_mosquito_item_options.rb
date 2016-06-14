class CreateMosquitoItemOptions < ActiveRecord::Migration
  def change
    create_table :mosquito_item_options do |t|
      t.string :title
      t.string :slug
      t.integer :price
      t.belongs_to :mosquito_item
      t.has_attached_file :image

      t.timestamps null: false
    end
  end
end
