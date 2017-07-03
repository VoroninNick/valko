class CreateMainBanners < ActiveRecord::Migration
  def change
    create_table :main_banners do |t|
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
