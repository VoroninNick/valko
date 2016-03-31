class AddDeckingColumnToLineItem < ActiveRecord::Migration
  def change
    change_table :line_items do |t|
      t.belongs_to :roof_rail_item
      t.string :color

    end
  end
end
