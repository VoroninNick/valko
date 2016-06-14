class CreateMosquitoItems < ActiveRecord::Migration
  def change
    create_table :mosquito_items do |t|
      t.string :title
      t.string :slug
      t.string :mosquito_grid_type
      t.string :mosquito_grid_option
      t.text :short_description
      t.text :description
      t.boolean :published

      t.timestamps null: false
    end
  end
end
