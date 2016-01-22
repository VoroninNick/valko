class CreateAboutBrands < ActiveRecord::Migration
  def change
    create_table :about_brands do |t|
      t.string :title
      t.string :slug
      t.attachment :avatar
      t.text :description

      t.timestamps null: false
    end
  end
end
