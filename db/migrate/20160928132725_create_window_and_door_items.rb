class CreateWindowAndDoorItems < ActiveRecord::Migration
  def change
    create_table :window_and_door_items do |t|
      t.string :title
      t.string :slug

      t.text :short_description
      t.text :description
      t.boolean :published

      t.string :side_face
      t.string :condensation
      t.string :glass
      t.string :furniture
      t.string :handle
      t.text :present_color

      t.attachment :avatar
      t.attachment :avatar_plus

      t.timestamps null: false
    end
  end
end
