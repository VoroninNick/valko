class CreateInformation < ActiveRecord::Migration
  def change
    create_table :information do |t|
      t.string :title
      t.string :slug
      t.attachment :cover
      t.text :short_description
      t.text :description
      t.boolean :published
      t.integer :position
      t.boolean :main

      t.timestamps null: false
    end
  end
end
