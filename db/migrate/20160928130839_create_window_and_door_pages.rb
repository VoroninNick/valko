class CreateWindowAndDoorPages < ActiveRecord::Migration
  def change
    create_table :window_and_door_pages do |t|
      t.string :title
      t.string :subtitle
      t.string :slug
      t.text :header_description
      t.text :footer_description
      t.string :page_name

      t.timestamps null: false
    end
  end
end
