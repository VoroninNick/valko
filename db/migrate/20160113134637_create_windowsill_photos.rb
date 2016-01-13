class CreateWindowsillPhotos < ActiveRecord::Migration
  def change
    create_table :windowsill_photos do |t|
      t.string :title
      t.attachment :image
      t.belongs_to :windowsill

      t.timestamps null: false
    end
  end
end
