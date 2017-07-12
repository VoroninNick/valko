class CreateTestimonials < ActiveRecord::Migration
  def change
    create_table :testimonials do |t|
      t.boolean :published
      t.integer :position
      t.boolean :main
      t.boolean :on_index_page
      t.attachment :avatar
      t.text :description
      t.string :name
      t.date :date_post

      t.timestamps null: false
    end
  end
end
