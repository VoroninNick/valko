class CreatePhotoGalleries < ActiveRecord::Migration
  def change
    create_table :photo_galleries do |t|
      t.string :title
      t.string :alt
      t.has_attached_file :image
      t.integer :imageable_id
      t.string :imageable_type

      t.timestamps null: false
    end
  end
end
