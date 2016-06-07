class CreateMosquitoGrids < ActiveRecord::Migration
  def change
    create_table :mosquito_grids do |t|
      t.string :page_name
      t.string :title
      t.string :subtitle
      t.string :slug
      t.text :header_description
      t.text :footer_description

      t.timestamps null: false
    end
  end
end
