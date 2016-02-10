class CreateSeos < ActiveRecord::Migration
  def change
    create_table :seos do |t|
      t.string :seo_title
      t.text :seo_description
      t.text :keywords
      t.integer :seo_poly_id
      t.string :seo_poly_type

      t.timestamps null: false
    end
  end
end
