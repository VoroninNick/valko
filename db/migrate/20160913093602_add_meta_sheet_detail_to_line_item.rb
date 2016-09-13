class AddMetaSheetDetailToLineItem < ActiveRecord::Migration
  def change
    change_table :line_items do |t|
      t.belongs_to :metal_sheet_detail
    end
  end
end
