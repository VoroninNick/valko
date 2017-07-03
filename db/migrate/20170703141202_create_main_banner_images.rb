class CreateMainBannerImages < ActiveRecord::Migration
  def change
    create_table :main_banner_images do |t|
      t.string :title
      t.belongs_to :main_banner
      t.attachment :image
      t.integer :position
      t.boolean :published

      t.timestamps null: false
    end
  end
end
