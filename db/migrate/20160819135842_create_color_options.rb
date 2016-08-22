class CreateColorOptions < ActiveRecord::Migration
  def change
    create_table :color_options do |t|
      t.string :title
      t.attachment :image
      t.integer :price
      t.boolean :published

      t.integer :col_option_id
      t.string :col_option_type

      t.timestamps null: false
    end
  end
end
