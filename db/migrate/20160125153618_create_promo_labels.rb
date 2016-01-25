class CreatePromoLabels < ActiveRecord::Migration
  def change
    create_table :promo_labels do |t|
      t.string :title
      t.string :slug
      t.attachment :icon
      t.integer :position
      t.boolean :published

      t.timestamps null: false
    end
  end
end
