class CreateAboutBanners < ActiveRecord::Migration
  def change
    create_table :about_banners do |t|
      t.string :title
      t.attachment :image
      t.integer :position
      t.boolean :published

      t.timestamps null: false
    end
  end
end
