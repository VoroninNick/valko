class CreateSkylights < ActiveRecord::Migration
  def change
    create_table :skylights do |t|
      t.string :size
      t.integer :price
      t.belongs_to :skylight_model

      t.timestamps null: false
    end
  end
end
