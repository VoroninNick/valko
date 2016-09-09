class CreateMetalSheets < ActiveRecord::Migration
  def change
    create_table :metal_sheets do |t|
      t.string :title
      t.text :description
      t.text :short_description
      t.attachment :drawing

      t.string :video_title
      t.string :video_url
      t.attachment :video_poster
      t.boolean :video_published

      t.timestamps null: false
    end
  end
end
