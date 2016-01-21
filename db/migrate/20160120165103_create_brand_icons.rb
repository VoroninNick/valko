class CreateBrandIcons < ActiveRecord::Migration
  def change
    create_table :brand_icons do |t|
      t.string :title
      t.string :slug
      t.attachment :icon
      t.belongs_to :brand

      t.timestamps null: false
    end
  end
end
