class CreateFastenerOptions < ActiveRecord::Migration
  def change
    create_table :fastener_options do |t|
      t.string :title
      t.string :slug
      t.boolean :published

      t.string :appointment
      t.string :producer

      t.belongs_to :fastener

      t.timestamps null: false
    end
  end
end
