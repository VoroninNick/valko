class CreateMembranes < ActiveRecord::Migration
  def change
    create_table :membranes do |t|
      t.string :title
      t.string :slug

      t.string :appointment

      t.attachment :image
      t.text :short_description
      t.float :price

      t.text :description

      t.string :video_title
      t.string :video_url
      t.attachment :video_poster
      t.boolean :video_published

      t.timestamps null: false
    end
  end
end
