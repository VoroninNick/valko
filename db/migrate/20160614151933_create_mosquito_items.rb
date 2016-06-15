class CreateMosquitoItems < ActiveRecord::Migration
  def change
    create_table :mosquito_items do |t|
      t.string :title
      t.string :slug
      t.string :mosquito_grid_type

      t.text :short_description
      t.text :description
      t.boolean :published
      t.float :min_square

      t.boolean :pockets
      t.boolean :curtain
      t.boolean :holders
      t.boolean :screws
      t.boolean :guides

      t.timestamps null: false
    end
  end
end
