class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :title
      t.string :slug
      t.attachment :avatar
      t.text :short_description
      t.text :description

      t.timestamps null: false
    end
  end
end
