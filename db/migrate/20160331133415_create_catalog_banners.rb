class CreateCatalogBanners < ActiveRecord::Migration
  def change
    create_table :catalog_banners do |t|
      t.string :title
      t.attachment :image
      t.integer :position
      t.boolean :published
      t.integer :cat_banner_id
      t.string :cat_banner_type

      t.timestamps null: false
    end
  end
end
