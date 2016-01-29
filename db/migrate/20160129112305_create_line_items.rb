class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.belongs_to :cart
      t.references :windowsill
      t.integer :quantity
      t.string :type
      t.boolean :with_gag
      t.integer :weight
      t.integer :long

      t.timestamps null: false
    end
  end
end
