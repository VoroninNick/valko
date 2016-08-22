class CreateWindowsillPages < ActiveRecord::Migration
  def change
    create_table :windowsill_pages do |t|
      t.text :description
      t.string :title

      t.timestamps null: false
    end
  end
end
