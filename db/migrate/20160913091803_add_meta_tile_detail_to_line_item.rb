class AddMetaTileDetailToLineItem < ActiveRecord::Migration
  def change
    change_table :line_items do |t|
      t.belongs_to :metal_tile_detail
    end
  end
end
