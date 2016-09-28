class CreateWindowAndDoorColors < ActiveRecord::Migration
  def change
    create_table :window_and_door_colors do |t|
      t.string :title
      t.integer :position
      t.belongs_to :window_and_door_item
      t.attachment :image

      t.timestamps null: false
    end
  end
end
