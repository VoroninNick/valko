class CreatePageAbouts < ActiveRecord::Migration
  def change
    create_table :page_abouts do |t|
      t.text :top_block
      t.text :bottom_block

      t.timestamps null: false
    end
  end
end
