class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.string :key
      t.string :slug
      t.integer :value
      t.integer :priceable_id
      t.string :priceable_type

      t.timestamps null: false
    end
  end
end
