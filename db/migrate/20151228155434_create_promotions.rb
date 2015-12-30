class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.string :title
      t.string :slug
      t.attachment :cover
      t.text :short_description
      t.text :description
      t.boolean :published
      t.integer :position
      t.boolean :main
      t.date :start_date
      t.date :date_of

      t.timestamps null: false
    end
  end
end
