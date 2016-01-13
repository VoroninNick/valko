class CreateWindowsills < ActiveRecord::Migration
  def change
    create_table :windowsills do |t|
      t.string :title
      t.string :slug
      t.text :description
      t.boolean :status
      t.belongs_to :brand
      t.boolean :published

      t.timestamps null: false
    end
  end
end
