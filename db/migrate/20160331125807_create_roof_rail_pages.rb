class CreateRoofRailPages < ActiveRecord::Migration
  def change
    create_table :roof_rail_pages do |t|
      t.string :title
      t.string :slug
      t.text :header_description
      t.text :footer_description

      t.timestamps null: false
    end
  end
end
